# Draft project roadmap

## Raspberry Pi developer experience

- Use physical header numbering as the default. Show both numbering schemes in the pin reference and evaluate an explicit Raspberry Pi-style numbering option. For example, physical pin 11 is labeled GPIO 17 on the card, while physical pin 17 is a power rail. Resolve aliases only for electrically verified lines.
- Follow familiar GPIO workflows for opening a line, selecting input or output, reading or writing a value, and releasing it. Evaluate compatibility with `System.Device.Gpio` so existing .NET GPIO examples can carry over where practical.
- Provide a blink example and a button input example with wiring diagrams. Document support for pull modes, edge detection, and alternate functions per pin as those capabilities are verified.

## Milestones

1. **Identify the hardware and software path.** Complete the [research plan](Research-Plan.md). Publish the evidence-backed pin map, documented Windows prerequisites, and a recommendation to prototype, pursue vendor support, or pause at a specific blocker.
2. **Prove a small Windows backend.** Demonstrate repeatable read and write on one verified header line. Use Python for diagnostics where it can call the discovered interface directly. Check cleanup, exclusive ownership, and behavior after process exit and reboot before adding pins.
3. **Choose the .NET integration.** Compare a C# wrapper over the verified Windows API or device interface with a Python bridge if an existing Python package provides access worth reusing. Compare install and update burden, permissions, maintenance, latency, and error handling. Evaluate a `System.Device.Gpio` adapter if the pin model fits. Either language still depends on the underlying Windows hardware access.
4. **Build a usable .NET 10 release.** Provide a documented API using physical header pin numbers, basic digital input and output, explicit resource disposal, and understandable errors for unsupported or busy lines. Expose only verified lines for supported board and firmware revisions. Consider edge events after the basic backend works. Treat hardware PWM and bus protocols as follow-on work.
5. **Verify deployment and publish.** Test the supported Windows configuration from a clean install, including install and removal, ordinary-user behavior where supported, concurrent access, shutdown and reboot, and physical input/output on the supported lines. Package the library and any required signed driver or runtime dependencies. Publish a .NET sample, wiring guidance, and the supported board, firmware, OS, and pin matrix.
