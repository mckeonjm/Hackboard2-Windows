cat << 'EOF' > collect_hb2_ec.sh
#!/bin/bash
set -e

OUTDIR="hackboard2_ec_dump"
mkdir -p "$OUTDIR"

echo "[1/5] Installing required tools (acpica-tools, gpiod)..."
sudo apt-get update -qq
sudo apt-get install -y -qq acpica-tools gpiod xxd pciutils usbutils

echo "[2/5] Dumping and decompiling ACPI tables (DSDT & SSDTs)..."
sudo cp /sys/firmware/acpi/tables/DSDT "$OUTDIR/dsdt.dat"
sudo cp /sys/firmware/acpi/tables/SSDT* "$OUTDIR/" 2>/dev/null || true
sudo chown -R "$USER:$USER" "$OUTDIR"

cd "$OUTDIR"
iasl -d dsdt.dat > iasl_dsdt.log 2>&1 || true
for f in SSDT*; do
    [ -f "$f" ] && iasl -d "$f" >> iasl_ssdt.log 2>&1 || true
done
cd ..

echo "[3/5] Extracting Embedded Controller (EC) sections from DSDT..."
grep -n -C 5 -E "PNP0C09|EmbeddedControl|EC0|ERAM|GPIO" "$OUTDIR/dsdt.dsl" > "$OUTDIR/ec_acpi_matches.txt" || true

echo "[4/5] Attempting to dump live EC RAM via ec_sys..."
sudo modprobe ec_sys 2>/dev/null || true
if [ -f /sys/kernel/debug/ec/ec0/io ]; then
    sudo xxd /sys/kernel/debug/ec/ec0/io > "$OUTDIR/ec_ram_baseline.txt"
    sudo cp /sys/kernel/debug/ec/ec0/io "$OUTDIR/ec_ram_baseline.bin"
    echo " -> Live EC RAM captured successfully!"
else
    echo " -> /sys/kernel/debug/ec/ec0/io not available (Secure Boot may be blocking debugfs)." > "$OUTDIR/ec_ram_baseline.txt"
fi

echo "[5/5] Collecting GPIO chips, kernel messages, and loaded modules..."
sudo gpioinfo > "$OUTDIR/gpioinfo.txt" 2>&1 || true
ls -la /sys/class/gpio/ > "$OUTDIR/sys_class_gpio.txt" 2>&1 || true
ls -la /sys/bus/acpi/devices/ > "$OUTDIR/acpi_devices.txt" 2>&1 || true
dmesg | grep -iE "acpi|gpio|ite|it87|ec|lpc|espi|pinctrl|i2c|smbus" > "$OUTDIR/dmesg_filtered.txt" 2>&1 || true
lsmod > "$OUTDIR/lsmod.txt" 2>&1 || true

tar -czf hackboard2_ec_dump.tar.gz "$OUTDIR"
echo "=========================================================="
echo "Done! Archive saved to: $(pwd)/hackboard2_ec_dump.tar.gz"
echo "=========================================================="
EOF

chmod +x collect_hb2_ec.sh
./collect_hb2_ec.sh
