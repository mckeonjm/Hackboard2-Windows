// Diagnostic table for PCB PZ08C20045B0 with the analyzed ITE EC-V14.4 image.
DefinitionBlock ("", "SSDT", 2, "HACKBD", "HB2PIN31", 1)
{
    External (\_SB.PCI0.SBRG.H_EC, DeviceObj)
    External (\_SB.PCI0.SBRG.H_EC.ECF2, OpRegionObj)
    External (\_SB.PCI0.SBRG.H_EC.ECMT, MutexObj)
    External (\_SB.PCI0.SBRG.H_EC.ECAV, IntObj)

    Scope (\_SB.PCI0.SBRG.H_EC)
    {
        Field (ECF2, ByteAcc, Lock, Preserve)
        {
            Offset (0x40),
            HSEL, 8, // Configuration selector
            HCFG, 8, // Configuration argument
            HSCR, 8, // Snapshot request/status
            Offset (0x44),
            HSBM, 40 // Snapshot bitmap for indices 0 through 39
        }
    }

    Scope (\_SB)
    {
        Device (HB31)
        {
            Name (_HID, EisaId ("PNP0C14"))
            Name (_UID, "HB2P31")
            Name (_WDG, Buffer ()
            {
                // {B0D63215-3084-4C8D-8391-FF216376E0A1}, object P1.
                0x15, 0x32, 0xD6, 0xB0, 0x84, 0x30, 0x8D, 0x4C,
                0x83, 0x91, 0xFF, 0x21, 0x63, 0x76, 0xE0, 0xA1,
                0x50, 0x31, 0x01, 0x02
            })

            Method (WMP1, 3, Serialized)
            {
                If (Arg0 != Zero)
                {
                    Return (5)
                }

                Switch (ToInteger (Arg1))
                {
                    Case (One) { Return (RD31 ()) }
                    Case (2) { Return (TR31 ()) }
                    Case (4) { Return (PL31 (0x26, One)) }
                    Case (5) { Return (PL31 (0x27, Zero)) }
                    Default { Return (5) }
                }
            }

            // Caller supplies a weak bias opposite the requested drive.
            // Only the two fixed WMI cases can select a drive configuration.
            Method (PL31, 2, Serialized)
            {
                If (RD31 () != Arg1) { Return (6) }
                If (Acquire (\_SB.PCI0.SBRG.H_EC.ECMT, 0x03E8)) { Return (4) }

                Local0 = 2
                If (\_SB.PCI0.SBRG.H_EC.ECAV)
                {
                    Local0 = 3
                    If (\_SB.PCI0.SBRG.H_EC.HSCR == Zero)
                    {
                        Local1 = \_SB.PCI0.SBRG.H_EC.HSEL
                        Local2 = \_SB.PCI0.SBRG.H_EC.HCFG
                        \_SB.PCI0.SBRG.H_EC.HSEL = 31
                        \_SB.PCI0.SBRG.H_EC.HCFG = Arg0
                        \_SB.PCI0.SBRG.H_EC.HSCR = 0xAA
                        Local3 = WACK ()
                        If (Local3 == 0x55) { Sleep (1000) }

                        // Always request input, including after an uncertain write.
                        // Mode 1 selects input. Mode 0 skips the direction change.
                        \_SB.PCI0.SBRG.H_EC.HCFG = 0x25
                        \_SB.PCI0.SBRG.H_EC.HSCR = 0xAA
                        Local4 = WACK ()
                        \_SB.PCI0.SBRG.H_EC.HSCR = Zero
                        \_SB.PCI0.SBRG.H_EC.HCFG = Local2
                        \_SB.PCI0.SBRG.H_EC.HSEL = Local1
                        Local0 = (Local3 | (Local4 << 8))
                    }
                }

                Release (\_SB.PCI0.SBRG.H_EC.ECMT)
                Return (Local0)
            }

            Method (WACK, 0, Serialized)
            {
                Local0 = 20
                While ((Local0 != Zero) && (\_SB.PCI0.SBRG.H_EC.HSCR == 0xAA))
                {
                    Sleep (10)
                    Decrement (Local0)
                }
                Return (\_SB.PCI0.SBRG.H_EC.HSCR)
            }

            // Returns 0 or 1 for a sample, 2 when the EC is unavailable,
            // 3 when the mailbox is occupied, and 4 on a mutex timeout.
            Method (RD31, 0, Serialized)
            {
                Local0 = TR31 ()
                CreateByteField (Local0, Zero, STAT)
                CreateByteField (Local0, 17, PINB)
                If (STAT == Zero)
                {
                    // Physical pin 31 toggled mask 0x40 in the live Windows trace.
                    Return ((PINB & 0x40) >> 6)
                }
                Return (STAT)
            }

            // Five DWORDs returned through WMI. The first is the status.
            // Bitmap bytes 0x44-0x48 start at offsets 4, 9, and 14.
            // Offset 19 contains the last observed request/status byte.
            Method (TR31, 0, Serialized)
            {
                Local0 = Buffer (20) {}
                CreateDWordField (Local0, Zero, STAT)
                CreateField (Local0, 32, 40, PREB)
                CreateField (Local0, 72, 40, RUNB)
                CreateField (Local0, 112, 40, ENDB)
                CreateByteField (Local0, 19, MAIL)

                STAT = 4
                If (Acquire (\_SB.PCI0.SBRG.H_EC.ECMT, 0x03E8))
                {
                    Return (Local0)
                }

                STAT = 2
                If (\_SB.PCI0.SBRG.H_EC.ECAV)
                {
                    STAT = 3
                    MAIL = \_SB.PCI0.SBRG.H_EC.HSCR
                    If (MAIL == Zero)
                    {
                        PREB = \_SB.PCI0.SBRG.H_EC.HSBM
                        \_SB.PCI0.SBRG.H_EC.HSCR = 0x55
                        Sleep (100)
                        RUNB = \_SB.PCI0.SBRG.H_EC.HSBM
                        MAIL = \_SB.PCI0.SBRG.H_EC.HSCR
                        If (MAIL == 0x55)
                        {
                            \_SB.PCI0.SBRG.H_EC.HSCR = Zero
                            Sleep (20)
                            ENDB = \_SB.PCI0.SBRG.H_EC.HSBM
                            STAT = Zero
                        }
                    }
                }

                Release (\_SB.PCI0.SBRG.H_EC.ECMT)
                Return (Local0)
            }
        }
    }
}
