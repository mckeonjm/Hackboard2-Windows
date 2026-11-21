#!/bin/sh
# Inspect one Intel GPIO candidate, or pulse it with explicit --pulse.
set -eu
export LC_ALL=C

fail() {
    printf '%s\n' "$*" >&2
    exit 1
}

if [ "${1:-}" = '--sweep' ] || [ "${1:-}" = '--sweep-expanded' ]; then
    [ "$#" -eq 1 ] || fail 'Usage: sudo sh probe_intel_gpio.sh --sweep | --sweep-expanded'
    sweep=$1
    [ -t 0 ] || fail 'The sweep requires an interactive terminal.'
    for tool in gpiodetect gpioinfo gpioget gpioset; do
        command -v "$tool" >/dev/null 2>&1 || fail 'Install Debian gpiod first.'
    done
    gpioset --version | grep -q 'v2\.' || fail 'Requires libgpiod 2.x.'
    candidates=$(
        for controller in INT3453:00 INT3453:01 INT3453:02 INT3453:03; do
            pins="/sys/kernel/debug/pinctrl/$controller/pins"
            [ -r "$pins" ] || fail "Cannot read $pins. Run as root with debugfs available."
            awk -v sweep="$sweep" '
                $1 == "pin" && $0 ~ / GPIO / && $0 !~ /\[/ {
                    generic = ($3 ~ /^\(GPIO_[0-9]+\)$/)
                    if ((sweep == "--sweep" && generic) ||
                        (sweep == "--sweep-expanded" && !generic &&
                         $3 ~ /^\((LPSS_(I2C|UART|SPI)|PWM)/)) print $2, $3
                }
            ' "$pins" |
            while read -r line name; do
                if reason=$(sh "$0" "$controller" "$line" --inspect 2>&1); then
                    printf '%s %s %s\n' "$controller" "$line" "$name"
                else
                    printf 'Skipped %s offset %s %s: %s\n' "$controller" "$line" "$name" "$(printf '%s\n' "$reason" | tail -n 1)" >&2
                fi
            done
        done
    )
    [ -n "$candidates" ] || fail 'No candidates passed the metadata checks.'
    count=$(printf '%s\n' "$candidates" | wc -l | tr -d ' ')
    index=1
    printf 'Found %s candidates. Metadata checks do not establish board wiring.\n' "$count"
    printf '%s\n' 'Connect the scope before proceeding. Press Ctrl+C to interrupt a pulse.'
    printf 'Type START to begin, or press Enter to quit: '
    read -r answer || exit 0
    [ "$answer" = START ] || exit 0
    while :; do
        entry=$(printf '%s\n' "$candidates" | sed -n "${index}p")
        read -r controller line name <<EOF
$entry
EOF
        printf '\n[%s/%s] %s offset %s %s\n' "$index" "$count" "$controller" "$line" "$name"
        if sh "$0" "$controller" "$line" --pulse; then
            printf '%s\n' 'Pulse finished. Record this line if the scope matched.'
        else
            printf '%s\n' 'Test failed or was interrupted. Check the output above.'
        fi
        while :; do
            printf '[R]epeat, [N]ext, [B]ack, [Q]uit: '
            read -r answer || exit 0
            case "$answer" in
                r|R) break ;;
                n|N)
                    if [ "$index" -eq "$count" ]; then
                        printf '%s\n' 'End of candidate list. Use R, B, or Q.'
                    else
                        index=$((index + 1))
                        break
                    fi ;;
                b|B)
                    if [ "$index" -gt 1 ]; then
                        index=$((index - 1))
                        break
                    fi
                    printf '%s\n' 'Already at the first candidate.' ;;
                q|Q) exit 0 ;;
            esac
        done
    done
fi

[ "$#" -eq 2 ] || [ "$#" -eq 3 ] ||
    fail 'Usage: sudo sh probe_intel_gpio.sh --sweep | INT3453:NN OFFSET [--pulse]'
chip=$1
offset=$2
mode=${3:---inspect}
case "$mode" in --inspect|--pulse) ;; *) fail 'Expected --pulse or --inspect.' ;; esac
case "$chip" in INT3453:0[0-3]) ;; *) fail 'Expected an INT3453:00 through INT3453:03 chip label.' ;; esac
case "$offset" in 0|[1-9]|[1-9][0-9]) ;; *) fail 'Expected a decimal line offset from 0 through 99.' ;; esac

for tool in gpiodetect gpioinfo gpioget gpioset; do
    command -v "$tool" >/dev/null 2>&1 || fail 'Install Debian gpiod first.'
done
gpioset --version | grep -q 'v2\.' || fail 'Requires libgpiod 2.x.'

chips=$(gpiodetect)
device=$(printf '%s\n' "$chips" | awk -v label="[$chip]" '$2 == label {print $1}')
case "$device" in gpiochip[0-9]*) ;; *) fail "Could not resolve $chip." ;; esac
info=$(gpioinfo --chip "$device")
printf '%s\n' "$info" | awk -v offset="$offset" '
    $1 == "line" && $2 == offset ":" {
        print
        if ($3 == "unnamed" && $4 == "input" && NF == 4) found = 1
    }
    END { exit !found }
' || fail 'Expected an unnamed input with no consumer or other flags.'

pinctrl="/sys/kernel/debug/pinctrl/$chip"
[ -r "$pinctrl/pins" ] && [ -r "$pinctrl/pinmux-pins" ] &&
    [ -r "$pinctrl/gpio-ranges" ] ||
    fail 'Pinctrl debugfs data is unavailable. Run as root in the Debian live session.'
awk '
    / PINS \[/ {
        split($0, pads, /PINS \[/)
        if (($1 + 0) != (pads[2] + 0)) mismatch = 1
        found = 1
    }
    END { exit (!found || mismatch) }
' "$pinctrl/gpio-ranges" || fail 'GPIO offsets and pinctrl pad indices could not be matched.'
pad=$(awk -v offset="$offset" '$1 == "pin" && $2 == offset' "$pinctrl/pins")
mux=$(awk -v offset="$offset" '$1 == "pin" && $2 == offset' "$pinctrl/pinmux-pins")
printf '%s\n' "$pad" "$mux"
case "$pad" in *'['*) fail 'Pad has ownership or lock flags.' ;; *' GPIO '*) ;; *) fail 'Pad is outside GPIO mode.' ;; esac
case "$mux" in *'(MUX UNCLAIMED) (GPIO UNCLAIMED)'*) ;; *) fail 'Pad has a reported pinctrl owner.' ;; esac

if [ "$mode" = '--inspect' ]; then
    printf '%s\n' 'Metadata checks passed. Confirm board-specific routing evidence before pulsing.'
    exit 0
fi

restore_input() {
    status=$?
    trap - EXIT
    if ! gpioget --chip "$device" "$offset" >/dev/null; then
        printf '%s\n' "Could not restore $chip offset $offset to input. Reboot the live session before retesting." >&2
        exit 1
    fi
    exit "$status"
}

trap restore_input EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
printf '%s\n' "Pulsing $chip offset $offset for 3 seconds. Expected low/high intervals: 0.5s/0.75s/0.5s/0.75s/0.5s."
gpioset --chip "$device" --consumer hackboard-header-probe \
    --toggle 500ms,750ms,500ms,750ms,500ms,0 "$offset=0"
