#!/bin/sh
# Read-only Linux inventory. Run with root privileges for kernel diagnostics.
set -eu
export LC_ALL=C

section() {
    printf '\n=== %s ===\n' "$1"
}

section 'Kernel and distribution'
uname -srvm
cat /etc/os-release

section 'ACPI device bindings'
for device in /sys/bus/acpi/devices/INT3453:* /sys/bus/acpi/devices/PNP0C09:*; do
    [ -d "$device" ] || continue
    printf '%s\n' "${device##*/}"
    for attribute in path hid uid status; do
        [ -r "$device/$attribute" ] || continue
        printf '  %s: ' "$attribute"
        cat "$device/$attribute"
    done
    if [ -L "$device/driver" ]; then
        printf '  driver: %s\n' "$(readlink "$device/driver")"
    fi
done

for command in gpiodetect gpioinfo; do
    section "$command"
    if command -v "$command" >/dev/null 2>&1; then
        "$command" --version
        "$command" || printf '%s failed\n' "$command"
    else
        printf '%s unavailable\n' "$command"
    fi
done

section 'GPIO character devices'
for device in /dev/gpiochip*; do
    [ -c "$device" ] || continue
    ls -l "$device"
done

section 'GPIO debug summary'
if [ -r /sys/kernel/debug/gpio ]; then
    cat /sys/kernel/debug/gpio
else
    printf '%s\n' 'GPIO debug summary unavailable'
fi

section 'Serial-bus bindings'
for bus in i2c spi serial serial-base; do
    for device in /sys/bus/"$bus"/devices/*; do
        [ -d "$device" ] || continue
        printf '%s/%s\n' "$bus" "${device##*/}"
        for attribute in name modalias; do
            [ -r "$device/$attribute" ] || continue
            printf '  %s: ' "$attribute"
            cat "$device/$attribute"
        done
        for link in driver firmware_node; do
            [ -L "$device/$link" ] || continue
            printf '  %s: %s\n' "$link" "$(readlink -f "$device/$link")"
        done
    done
done

section 'Serial device nodes'
for device in /dev/ttyS* /dev/spidev* /dev/i2c-*; do
    [ -c "$device" ] || continue
    ls -l "$device"
done

section 'Pinctrl ownership and mux state'
for controller in /sys/kernel/debug/pinctrl/*; do
    [ -d "$controller" ] || continue
    for attribute in pins gpio-ranges pinmux-pins; do
        [ -r "$controller/$attribute" ] || continue
        printf '\n--- %s/%s ---\n' "${controller##*/}" "$attribute"
        cat "$controller/$attribute"
    done
done

section 'Relevant kernel messages'
if messages=$(dmesg 2>&1); then
    printf '%s\n' "$messages" | grep -Ei 'gpio|pinctrl|INT3453|PNP0C09|ACPI: EC|embedded controller' || :
else
    printf '%s\n' "$messages"
fi
