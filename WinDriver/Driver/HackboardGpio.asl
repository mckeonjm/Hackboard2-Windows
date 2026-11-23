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
                    Case (4) { Return (PULS (31, 0x26, One)) }
                    Case (5) { Return (PULS (31, 0x27, Zero)) }
                    Case (6) { Return (PULS (19, 0x27, 2)) }
                    Case (7) { Return (PULS (19, 0x26, 2)) }
                    Case (8) { Return (PULS (21, 0x27, 2)) }
                    Case (9) { Return (PULS (21, 0x26, 2)) }
                    Case (10) { Return (PULS (23, 0x27, 2)) }
                    Case (11) { Return (PULS (23, 0x26, 2)) }
                    Case (12) { Return (PULS (24, 0x27, 2)) }
                    Case (13) { Return (PULS (24, 0x26, 2)) }
                    Case (106) { Return (PULS (3, 0x27, 2)) }
                    Case (107) { Return (PULS (3, 0x26, 2)) }
                    Case (110) { Return (PULS (5, 0x27, 2)) }
                    Case (111) { Return (PULS (5, 0x26, 2)) }
                    Case (114) { Return (PULS (7, 0x27, 2)) }
                    Case (115) { Return (PULS (7, 0x26, 2)) }
                    Case (116) { Return (PULS (8, 0x27, 2)) }
                    Case (117) { Return (PULS (8, 0x26, 2)) }
                    Case (120) { Return (PULS (10, 0x27, 2)) }
                    Case (121) { Return (PULS (10, 0x26, 2)) }
                    Case (122) { Return (PULS (11, 0x27, 2)) }
                    Case (123) { Return (PULS (11, 0x26, 2)) }
                    Case (124) { Return (PULS (12, 0x27, 2)) }
                    Case (125) { Return (PULS (12, 0x26, 2)) }
                    Case (126) { Return (PULS (13, 0x27, 2)) }
                    Case (127) { Return (PULS (13, 0x26, 2)) }
                    Case (130) { Return (PULS (15, 0x27, 2)) }
                    Case (131) { Return (PULS (15, 0x26, 2)) }
                    Case (132) { Return (PULS (16, 0x27, 2)) }
                    Case (133) { Return (PULS (16, 0x26, 2)) }
                    Case (136) { Return (PULS (18, 0x27, 2)) }
                    Case (137) { Return (PULS (18, 0x26, 2)) }
                    Case (144) { Return (PULS (22, 0x27, 2)) }
                    Case (145) { Return (PULS (22, 0x26, 2)) }
                    Case (152) { Return (PULS (26, 0x27, 2)) }
                    Case (153) { Return (PULS (26, 0x26, 2)) }
                    Case (158) { Return (PULS (29, 0x27, 2)) }
                    Case (159) { Return (PULS (29, 0x26, 2)) }
                    Case (164) { Return (PULS (32, 0x27, 2)) }
                    Case (165) { Return (PULS (32, 0x26, 2)) }
                    Case (166) { Return (PULS (33, 0x27, 2)) }
                    Case (167) { Return (PULS (33, 0x26, 2)) }
                    Case (170) { Return (PULS (35, 0x27, 2)) }
                    Case (171) { Return (PULS (35, 0x26, 2)) }
                    Case (172) { Return (PULS (36, 0x27, 2)) }
                    Case (173) { Return (PULS (36, 0x26, 2)) }
                    Case (174) { Return (PULS (37, 0x27, 2)) }
                    Case (175) { Return (PULS (37, 0x26, 2)) }
                    Case (176) { Return (PULS (38, 0x27, 2)) }
                    Case (177) { Return (PULS (38, 0x26, 2)) }
                    Case (180) { Return (PULS (40, 0x27, 2)) }
                    Case (181) { Return (PULS (40, 0x26, 2)) }
                    Case (190) { Return (CONF (7, 0x25)) }
                    Case (191) { Return (CONF (11, 0x25)) }
                    Case (203) { Return (CONF (3, 0x25)) }
                    Case (303) { Return (RDPH (3)) }
                    Case (205) { Return (CONF (5, 0x25)) }
                    Case (305) { Return (RDPH (5)) }
                    Case (307) { Return (RDPH (7)) }
                    Case (208) { Return (CONF (8, 0x25)) }
                    Case (308) { Return (RDPH (8)) }
                    Case (210) { Return (CONF (10, 0x25)) }
                    Case (310) { Return (RDPH (10)) }
                    Case (311) { Return (RDPH (11)) }
                    Case (212) { Return (CONF (12, 0x25)) }
                    Case (312) { Return (RDPH (12)) }
                    Case (213) { Return (CONF (13, 0x25)) }
                    Case (313) { Return (RDPH (13)) }
                    Case (215) { Return (CONF (15, 0x25)) }
                    Case (315) { Return (RDPH (15)) }
                    Case (216) { Return (CONF (16, 0x25)) }
                    Case (316) { Return (RDPH (16)) }
                    Case (218) { Return (CONF (18, 0x25)) }
                    Case (318) { Return (RDPH (18)) }
                    Case (219) { Return (CONF (19, 0x25)) }
                    Case (319) { Return (RDPH (19)) }
                    Case (221) { Return (CONF (21, 0x25)) }
                    Case (321) { Return (RDPH (21)) }
                    Case (222) { Return (CONF (22, 0x25)) }
                    Case (322) { Return (RDPH (22)) }
                    Case (223) { Return (CONF (23, 0x25)) }
                    Case (323) { Return (RDPH (23)) }
                    Case (224) { Return (CONF (24, 0x25)) }
                    Case (324) { Return (RDPH (24)) }
                    Case (226) { Return (CONF (26, 0x25)) }
                    Case (326) { Return (RDPH (26)) }
                    Case (229) { Return (CONF (29, 0x25)) }
                    Case (329) { Return (RDPH (29)) }
                    Case (231) { Return (CONF (31, 0x25)) }
                    Case (331) { Return (RDPH (31)) }
                    Case (232) { Return (CONF (32, 0x25)) }
                    Case (332) { Return (RDPH (32)) }
                    Case (233) { Return (CONF (33, 0x25)) }
                    Case (333) { Return (RDPH (33)) }
                    Case (235) { Return (CONF (35, 0x25)) }
                    Case (335) { Return (RDPH (35)) }
                    Case (236) { Return (CONF (36, 0x25)) }
                    Case (336) { Return (RDPH (36)) }
                    Case (237) { Return (CONF (37, 0x25)) }
                    Case (337) { Return (RDPH (37)) }
                    Case (238) { Return (CONF (38, 0x25)) }
                    Case (338) { Return (RDPH (38)) }
                    Case (240) { Return (CONF (40, 0x25)) }
                    Case (340) { Return (RDPH (40)) }
                    Case (403) { Return (CONF (3, 0x26)) }
                    Case (503) { Return (CONF (3, 0x27)) }
                    Case (405) { Return (CONF (5, 0x26)) }
                    Case (505) { Return (CONF (5, 0x27)) }
                    Case (407) { Return (CONF (7, 0x26)) }
                    Case (507) { Return (CONF (7, 0x27)) }
                    Case (408) { Return (CONF (8, 0x26)) }
                    Case (508) { Return (CONF (8, 0x27)) }
                    Case (410) { Return (CONF (10, 0x26)) }
                    Case (510) { Return (CONF (10, 0x27)) }
                    Case (411) { Return (CONF (11, 0x26)) }
                    Case (511) { Return (CONF (11, 0x27)) }
                    Case (412) { Return (CONF (12, 0x26)) }
                    Case (512) { Return (CONF (12, 0x27)) }
                    Case (413) { Return (CONF (13, 0x26)) }
                    Case (513) { Return (CONF (13, 0x27)) }
                    Case (415) { Return (CONF (15, 0x26)) }
                    Case (515) { Return (CONF (15, 0x27)) }
                    Case (416) { Return (CONF (16, 0x26)) }
                    Case (516) { Return (CONF (16, 0x27)) }
                    Case (418) { Return (CONF (18, 0x26)) }
                    Case (518) { Return (CONF (18, 0x27)) }
                    Case (419) { Return (CONF (19, 0x26)) }
                    Case (519) { Return (CONF (19, 0x27)) }
                    Case (421) { Return (CONF (21, 0x26)) }
                    Case (521) { Return (CONF (21, 0x27)) }
                    Case (422) { Return (CONF (22, 0x26)) }
                    Case (522) { Return (CONF (22, 0x27)) }
                    Case (423) { Return (CONF (23, 0x26)) }
                    Case (523) { Return (CONF (23, 0x27)) }
                    Case (424) { Return (CONF (24, 0x26)) }
                    Case (524) { Return (CONF (24, 0x27)) }
                    Case (426) { Return (CONF (26, 0x26)) }
                    Case (526) { Return (CONF (26, 0x27)) }
                    Case (429) { Return (CONF (29, 0x26)) }
                    Case (529) { Return (CONF (29, 0x27)) }
                    Case (431) { Return (CONF (31, 0x26)) }
                    Case (531) { Return (CONF (31, 0x27)) }
                    Case (432) { Return (CONF (32, 0x26)) }
                    Case (532) { Return (CONF (32, 0x27)) }
                    Case (433) { Return (CONF (33, 0x26)) }
                    Case (533) { Return (CONF (33, 0x27)) }
                    Case (435) { Return (CONF (35, 0x26)) }
                    Case (535) { Return (CONF (35, 0x27)) }
                    Case (436) { Return (CONF (36, 0x26)) }
                    Case (536) { Return (CONF (36, 0x27)) }
                    Case (437) { Return (CONF (37, 0x26)) }
                    Case (537) { Return (CONF (37, 0x27)) }
                    Case (438) { Return (CONF (38, 0x26)) }
                    Case (538) { Return (CONF (38, 0x27)) }
                    Default { Return (5) }
                }
            }

            // Caller supplies a weak bias opposite the requested drive.
            // Fixed WMI methods select a continuity-matched pad and drive direction.
            Method (PULS, 3, Serialized)
            {
                // The operator checks the starting voltage for the other pins.
                If ((Arg2 != 2) && (RD31 () != Arg2)) { Return (6) }
                If (Acquire (\_SB.PCI0.SBRG.H_EC.ECMT, 0x03E8)) { Return (4) }

                Local0 = 2
                If (\_SB.PCI0.SBRG.H_EC.ECAV)
                {
                    Local0 = 3
                    If (\_SB.PCI0.SBRG.H_EC.HSCR == Zero)
                    {
                        Local1 = \_SB.PCI0.SBRG.H_EC.HSEL
                        Local2 = \_SB.PCI0.SBRG.H_EC.HCFG
                        \_SB.PCI0.SBRG.H_EC.HSEL = Arg0
                        \_SB.PCI0.SBRG.H_EC.HCFG = Arg1
                        \_SB.PCI0.SBRG.H_EC.HSCR = 0xAA
                        Local3 = WACK ()
                        Local5 = Zero
                        If (Local3 == 0x55)
                        {
                            Sleep (1000)
                            If (Arg2 == 2)
                            {
                                // Sample the predicted bitmap byte while the drive is active.
                                Local6 = (((Arg0 - One) >> 3) << 3)
                                Local5 = (0x01000000 | (((\_SB.PCI0.SBRG.H_EC.HSBM >> Local6) & 0xFF) << 16))
                            }
                        }

                        // Always request input, including after an uncertain write.
                        // Mode 1 selects input. Mode 0 skips the direction change.
                        \_SB.PCI0.SBRG.H_EC.HCFG = 0x25
                        \_SB.PCI0.SBRG.H_EC.HSCR = 0xAA
                        Local4 = WACK ()
                        \_SB.PCI0.SBRG.H_EC.HSCR = Zero
                        \_SB.PCI0.SBRG.H_EC.HCFG = Local2
                        \_SB.PCI0.SBRG.H_EC.HSEL = Local1
                        Local0 = (Local3 | (Local4 << 8) | Local5)
                    }
                }

                Release (\_SB.PCI0.SBRG.H_EC.ECMT)
                Return (Local0)
            }

            Method (CONF, 2, Serialized)
            {
                If (Acquire (\_SB.PCI0.SBRG.H_EC.ECMT, 0x03E8)) { Return (4) }
                Local0 = 2
                If (\_SB.PCI0.SBRG.H_EC.ECAV)
                {
                    Local0 = 3
                    If (\_SB.PCI0.SBRG.H_EC.HSCR == Zero)
                    {
                        Local1 = \_SB.PCI0.SBRG.H_EC.HSEL
                        Local2 = \_SB.PCI0.SBRG.H_EC.HCFG
                        \_SB.PCI0.SBRG.H_EC.HSEL = Arg0
                        \_SB.PCI0.SBRG.H_EC.HCFG = Arg1
                        \_SB.PCI0.SBRG.H_EC.HSCR = 0xAA
                        Local0 = WACK ()
                        \_SB.PCI0.SBRG.H_EC.HSCR = Zero
                        \_SB.PCI0.SBRG.H_EC.HCFG = Local2
                        \_SB.PCI0.SBRG.H_EC.HSEL = Local1
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
                Return (RDPH (31))
            }

            // Levels use the observed one-position selector-to-bitmap offset.
            Method (RDPH, 1, Serialized)
            {
                Local0 = TR31 ()
                CreateByteField (Local0, Zero, STAT)
                If (STAT != Zero) { Return (STAT) }

                Local1 = Arg0 - One
                Local2 = DerefOf (Index (Local0, 14 + (Local1 >> 3)))
                Return ((Local2 >> (Local1 & 7)) & One)
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
