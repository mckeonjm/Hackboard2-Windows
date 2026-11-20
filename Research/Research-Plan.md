# Hackboard 2 GPIO research plan

## Research question

For this Hackboard 2 board revision, which controller and driver own the signals on the 40-pin header, and can an ordinary Windows desktop application access a verified subset through a deployable interface?

## Starting evidence

- The [supplied card transcription](Hackboard2-GPIO-pinout.txt) gives physical pin numbers and Raspberry Pi-style signal labels. Pins 19, 21, and 23 also carry `GPC3`, `GPC5`, and `GPA6` suffixes. Treat these as leads and trace them to a controller before interpreting their numbering.
- Hackboard advertised Python for GPIO, described a Linux edition, and noted GPIO work during production. The package name, shipping image contents, and working Windows API are still open questions. [Campaign page](https://www.crowdsupply.com/hackboard/hb2) · [Production updates](https://www.crowdsupply.com/hackboard/hb2/updates)
- The advertised Intel N4020 makes the Linux Gemini Lake pinctrl implementation a useful reference for controller IDs and pad names. Header routing still needs board-specific evidence, including whether a separate controller or level shifter is involved. [Campaign specifications](https://www.crowdsupply.com/hackboard/hb2) · [Linux Gemini Lake pinctrl source](https://github.com/torvalds/linux/blob/master/drivers/pinctrl/intel/pinctrl-geminilake.c)
- Microsoft documents Windows GPIO controller drivers and an ACPI/RhProxy route to user mode. Its RhProxy documentation names specific editions and requires working controller drivers and declared resources. Check availability on the installed edition and build. [GPIO driver guide](https://learn.microsoft.com/en-us/windows-hardware/drivers/gpio/) · [User-mode GPIO exposure](https://learn.microsoft.com/en-us/windows/uwp/devices-sensors/enable-usermode-access)

## 1. Inventory the Windows host

- Record board markings and revision, non-identifying SMBIOS fields, BIOS version, Windows edition and build, Python version, and .NET SDK version. Photograph the header and pin 1 marking when physical access is available.
- Use read-only PowerShell/PnP inventory to record GPIO, serial I/O, ACPI and possible USB or embedded controllers. Capture hardware IDs, bound drivers, service and device status, problem codes, and assigned resources where available. Check whether RhProxy exists and whether enumeration through `Windows.Devices.Gpio` returns a controller. Record access errors, empty results, and unavailable APIs separately.
- Acquire ACPI tables through a read-only method. Correlate GPIO controller IDs, `GpioIo` and `GpioInt` resources, and firmware consumers with the driver inventory. Record the evidence for each suspected backend.

## 2. Find the board’s Linux GPIO path

- Follow the vendor and campaign support trail for a production schematic, verified pin table, driver bundle, factory Linux image, Python package, and sample. Record source, date, board revision, and image checksums where available.
- If a trustworthy image is available, inspect it offline for Python package metadata, GPIO examples, kernel modules, udev rules, and service configuration. Identify what the package actually calls. If a live Linux session is needed, coordinate a reboot and use removable media while keeping the internal Windows disk unmounted.
- Inventory kernel version, ACPI devices, pinctrl information and GPIO chip labels, line names, offsets, and consumers. Use `gpiodetect` and `gpioinfo` where available. A generic live image can help identify the controller. Factory package claims require evidence from the factory image or vendor materials. [Linux GPIO character device API](https://docs.kernel.org/userspace-api/gpio/chardev.html) · [Official Python bindings](https://libgpiod.readthedocs.io/en/v2.3.2/python_api.html)

## 3. Correlate the map and validate one line

Start with the [header routing findings](Header-Routing.md). Pins 19, 21, and 23 have an embedded-controller lead. Keep the Intel GPIO path open for the other header signals until their routing is known.

- Create a per-pin evidence table with physical position, card label, controller hardware ID, native pad, Linux chip label and offset, Windows resource or pin ID, mux and ownership, electrical limits, and dated evidence. Track card-listed, correlated, and electrically verified states separately.
- Begin with the header unloaded. Confirm orientation, ground with the board off, and rail voltages with the multimeter. Measure candidate idle levels and activity with a high-impedance oscilloscope probe. Establish the candidate line’s logic voltage, allowable input range, and ownership before driving it or claiming it as an output. Rail voltage alone is insufficient to establish GPIO tolerances.
- Select one confirmed free digital line. Check mux and owner before requesting it. Test input first using a ground-referenced, current-limited stimulus within the confirmed input range. If using the signal generator, verify amplitude, offset, and overshoot with the scope at the actual termination before connecting. For output, disconnect the generator and scope a slow low/high sequence into a high-impedance load. Capture idle, startup, and release states. Stop on a mapping conflict, unknown electrical limits, or firmware/driver ownership.

## 4. Decide whether Windows implementation is viable

- Prefer a working vendor or supported Windows user-mode interface. If unavailable, document whether the controller driver, firmware resource exposure, or both are missing. Evaluate a narrowly scoped signed driver only after confirming controller ownership, pin routing, a supported device/resource binding, and a deployment path. Keep early probes in user mode and leave firmware and driver configuration untouched during inventory.
- Record the board and OS baseline, mapping and measurement evidence, and a reproducible probe or precise blocker. A positive result requires repeatable Windows input and output on a physically verified header line. A Linux-only success is evidence for the map and controller, with Windows access still open.
- Keep raw machine-specific captures in the ignored `Research/local/` directory and publish redacted findings and reproducible commands in `Research/`.
