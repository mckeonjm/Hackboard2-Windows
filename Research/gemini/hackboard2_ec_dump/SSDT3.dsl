/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT3
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00004C2A (19498)
 *     Revision         0x02
 *     Checksum         0x45
 *     OEM ID           "INTEL "
 *     OEM Table ID     "RVPRtd3"
 *     OEM Revision     0x00000003 (3)
 *     Compiler ID      "BRXT"
 *     Compiler Version 0x0100000D (16777229)
 */
DefinitionBlock ("", "SSDT", 2, "INTEL ", "RVPRtd3", 0x00000003)
{
    External (_SB_.GGOV, MethodObj)    // 1 Arguments
    External (_SB_.GPC0, MethodObj)    // 1 Arguments
    External (_SB_.GPO0.AVBL, IntObj)
    External (_SB_.GPO0.ODPW, IntObj)
    External (_SB_.OSCO, UnknownObj)
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.I2C2, DeviceObj)
    External (_SB_.PCI0.I2C3, DeviceObj)
    External (_SB_.PCI0.I2C4, DeviceObj)
    External (_SB_.PCI0.I2C5, DeviceObj)
    External (_SB_.PCI0.I2C6, DeviceObj)
    External (_SB_.PCI0.I2C7, DeviceObj)
    External (_SB_.PCI0.PWM_, DeviceObj)
    External (_SB_.PCI0.RP01, DeviceObj)
    External (_SB_.PCI0.RP01.VDID, UnknownObj)
    External (_SB_.PCI0.RP02, DeviceObj)
    External (_SB_.PCI0.RP02.VDID, UnknownObj)
    External (_SB_.PCI0.RP03, DeviceObj)
    External (_SB_.PCI0.RP03.VDID, UnknownObj)
    External (_SB_.PCI0.RP04, DeviceObj)
    External (_SB_.PCI0.RP04.VDID, UnknownObj)
    External (_SB_.PCI0.RP05, DeviceObj)
    External (_SB_.PCI0.RP05.VDID, UnknownObj)
    External (_SB_.PCI0.RP06, DeviceObj)
    External (_SB_.PCI0.RP06.VDID, UnknownObj)
    External (_SB_.PCI0.SATA, DeviceObj)
    External (_SB_.PCI0.SATA.PRT0, DeviceObj)
    External (_SB_.PCI0.SATA.PRT1, DeviceObj)
    External (_SB_.PCI0.SDHA, DeviceObj)
    External (_SB_.PCI0.SDIO, DeviceObj)
    External (_SB_.PCI0.SPI1, DeviceObj)
    External (_SB_.PCI0.SPI2, DeviceObj)
    External (_SB_.PCI0.SPI3, DeviceObj)
    External (_SB_.PCI0.URT1, DeviceObj)
    External (_SB_.PCI0.URT2, DeviceObj)
    External (_SB_.PCI0.URT3, DeviceObj)
    External (_SB_.PCI0.URT4, DeviceObj)
    External (_SB_.PCI0.XDCI, DeviceObj)
    External (_SB_.PCI0.XHC_, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS01, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS02, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS03, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS04, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS05, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS06, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS07, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS08, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS09, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS01, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS02, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS03, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS04, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS05, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS06, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS07, DeviceObj)
    External (_SB_.SGOV, MethodObj)    // 2 Arguments
    External (_SB_.SPC0, MethodObj)    // 2 Arguments
    External (EMOD, IntObj)
    External (HGEN, UnknownObj)
    External (OSYS, UnknownObj)
    External (RCG0, IntObj)
    External (RPA1, IntObj)
    External (RPA2, IntObj)
    External (RPA3, IntObj)
    External (RPA4, IntObj)
    External (RPA5, IntObj)
    External (RPA6, IntObj)
    External (RTD3, IntObj)
    External (S0ID, UnknownObj)
    External (XDST, IntObj)
    External (ZPGE, IntObj)

    Scope (\_SB.PCI0.RP01)
    {
        Name (SLOT, One)
        Name (RSTG, Package (0x04)
        {
            One, 
            Zero, 
            0x00C507D0, 
            One
        })
        Name (PWRG, Package (0x04)
        {
            One, 
            Zero, 
            0x00C509B0, 
            One
        })
        Name (WAKG, Package (0x04)
        {
            One, 
            Zero, 
            0x00C508A0, 
            One
        })
        Name (SCLK, Package (0x03)
        {
            Zero, 
            0x00C508E0, 
            Zero
        })
        Name (WKEN, Zero)
        Name (LNRD, Zero)
        Method (UPRD, 1, Serialized)
        {
            If ((Arg0 <= 0x2710))
            {
                LNRD = Arg0
            }

            Return (LNRD) /* \_SB_.PCI0.RP01.LNRD */
        }

        Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
        {
            Return (0x04)
        }

        Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
        {
            If (Arg1)
            {
                WKEN = Zero
            }
            ElseIf ((Arg0 && Arg2))
            {
                WKEN = One
            }
            Else
            {
                WKEN = Zero
            }
        }

        PowerResource (PXP, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (PWRG [0x02])) == DerefOf (PWRG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                If ((DerefOf (RSTG [Zero]) != Zero))
                {
                    If ((DerefOf (RSTG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (RSTG [0x02])) == DerefOf (RSTG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Return (Zero)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Name (PCIA, Zero)
                If ((SLOT == One))
                {
                    Local3 = (0x07 & RPA1) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA1) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x02))
                {
                    Local3 = (0x07 & RPA2) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA2) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x03))
                {
                    Local3 = (0x07 & RPA3) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA3) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x04))
                {
                    Local3 = (0x07 & RPA4) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA4) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x05))
                {
                    Local3 = (0x07 & RPA5) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA5) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x06))
                {
                    Local3 = (0x07 & RPA6) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA6) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
            }

            Method (PON, 1, Serialized)
            {
                OperationRegion (PX02, SystemMemory, Arg0, 0x0380)
                Field (PX02, AnyAcc, NoLock, Preserve)
                {
                    VD02,   32, 
                    Offset (0x50), 
                    L0SE,   1, 
                        ,   3, 
                    LDIS,   1, 
                    Offset (0x52), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0xE2), 
                        ,   2, 
                    L23E,   1, 
                    L23R,   1, 
                    Offset (0xF4), 
                        ,   10, 
                    BPLL,   1, 
                    Offset (0x324), 
                        ,   3, 
                    LEDM,   1, 
                    Offset (0x338), 
                        ,   26, 
                    BDQA,   1
                }

                If ((DerefOf (SCLK [Zero]) == One))
                {
                    Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                    Local1 &= 0xFF9FFFFF
                    \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                }

                If ((DerefOf (WAKG [Zero]) != Zero))
                {
                    If ((DerefOf (WAKG [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                        Local1 &= 0xFFFFFBFF
                        \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                    }
                }

                If ((DerefOf (PWRG [Zero]) == One))
                {
                    If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != DerefOf (PWRG [
                        0x03])))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), DerefOf (PWRG [0x03]))
                        Sleep (0x64)
                    }
                }

                If ((VD02 != 0xFFFF))
                {
                    \_SB.SGOV (DerefOf (RSTG [0x02]), DerefOf (RSTG [0x03]))
                }

                BDQA = Zero
                BPLL = Zero
                L23R = One
                Sleep (0x10)
                Local0 = Zero
                While (L23R)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Name (PCIA, Zero)
                Switch (ToInteger (SLOT))
                {
                    Case (One)
                    {
                        Local3 = (0x07 & RPA1) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA1) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x02)
                    {
                        Local3 = (0x07 & RPA2) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA2) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x03)
                    {
                        Local3 = (0x07 & RPA3) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA3) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x04)
                    {
                        Local3 = (0x07 & RPA4) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA4) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x05)
                    {
                        Local3 = (0x07 & RPA5) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA5) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x06)
                    {
                        Local3 = (0x07 & RPA6) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA6) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP01.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Default
                    {
                    }

                }

                OperationRegion (PX02, SystemMemory, PCIA, 0x0380)
                Field (PX02, AnyAcc, NoLock, Preserve)
                {
                    VDID,   16, 
                    Offset (0x50), 
                    L0SE,   1, 
                        ,   3, 
                    LDIS,   1, 
                    Offset (0xE2), 
                        ,   2, 
                    L23E,   1, 
                    L23R,   1, 
                    Offset (0xF4), 
                        ,   10, 
                    BPLL,   1, 
                    Offset (0x324), 
                        ,   3, 
                    LEDM,   1, 
                    Offset (0x338), 
                        ,   26, 
                    BDQA,   1
                }

                L23E = One
                Sleep (0x10)
                Local0 = Zero
                While (L23E)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }

                BDQA = One
                BPLL = One
                If ((DerefOf (WAKG [Zero]) != Zero))
                {
                    If ((DerefOf (WAKG [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                        Local1 |= 0x0400
                        \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                    }
                }

                Divide (LNRD, 0x03E8, Local0, Local1)
                Sleep (Local1)
                If ((VDID != 0xFFFF))
                {
                    If ((DerefOf (RSTG [Zero]) != Zero))
                    {
                        If ((DerefOf (RSTG [Zero]) == One))
                        {
                            \_SB.SGOV (DerefOf (RSTG [0x02]), (DerefOf (RSTG [0x03]) ^ 
                                One))
                        }
                    }
                }

                If ((DerefOf (SCLK [Zero]) == One))
                {
                    Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                    Local1 &= 0xFF9FFFFF
                    Local1 |= 0x00400000
                    \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                }

                If ((DerefOf (PWRG [Zero]) == One))
                {
                    Local0 = ~DerefOf (PWRG [0x03])
                    If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != Local0))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), Local0)
                    }
                }
            }
        }

        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            PXP
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            PXP
        })
        Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
        {
            Return (0x02)
        }

        Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
        {
            Return (0x03)
        }

        Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
        {
            Return (0x02)
        }

        Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
        {
            Return (0x03)
        }
    }

    Scope (\_SB.PCI0.RP02)
    {
        Name (PCA2, Zero)
        Name (SLOT, 0x02)
        Name (RSTG, Package (0x04)
        {
            One, 
            Zero, 
            0x00C90670, 
            One
        })
        Name (PWRG, Package (0x04)
        {
            Zero, 
            Zero, 
            0x00C407B0, 
            Zero
        })
        Name (WAKG, Package (0x04)
        {
            Zero, 
            Zero, 
            0x00C508B0, 
            One
        })
        Name (SCLK, Package (0x03)
        {
            Zero, 
            0x00C508F0, 
            Zero
        })
        Name (WKEN, Zero)
        Name (LNRD, Zero)
        Method (UPRD, 1, Serialized)
        {
            If ((Arg0 <= 0x2710))
            {
                LNRD = Arg0
            }

            Return (LNRD) /* \_SB_.PCI0.RP02.LNRD */
        }

        Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
        {
            Return (0x04)
        }

        Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
        {
            If (Arg1)
            {
                WKEN = Zero
            }
            ElseIf ((Arg0 && Arg2))
            {
                WKEN = One
            }
            Else
            {
                WKEN = Zero
            }
        }

        PowerResource (PXP, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (PWRG [0x02])) == DerefOf (PWRG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                If ((DerefOf (RSTG [Zero]) != Zero))
                {
                    If ((DerefOf (RSTG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (RSTG [0x02])) == DerefOf (RSTG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Return (Zero)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Name (PCIA, Zero)
                If ((SLOT == One))
                {
                    Local3 = (0x07 & RPA1) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA1) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x02))
                {
                    Local3 = (0x07 & RPA2) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA2) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x03))
                {
                    Local3 = (0x07 & RPA3) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA3) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x04))
                {
                    Local3 = (0x07 & RPA4) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA4) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x05))
                {
                    Local3 = (0x07 & RPA5) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA5) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x06))
                {
                    Local3 = (0x07 & RPA6) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA6) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
            }

            Method (PON, 1, Serialized)
            {
                OperationRegion (PX02, SystemMemory, Arg0, 0x0380)
                Field (PX02, AnyAcc, NoLock, Preserve)
                {
                    VD02,   32, 
                    Offset (0x50), 
                    L0SE,   1, 
                        ,   3, 
                    LDIS,   1, 
                    Offset (0x52), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0xE2), 
                        ,   2, 
                    L23E,   1, 
                    L23R,   1, 
                    Offset (0xF4), 
                        ,   10, 
                    BPLL,   1, 
                    Offset (0x324), 
                        ,   3, 
                    LEDM,   1, 
                    Offset (0x338), 
                        ,   26, 
                    BDQA,   1
                }

                If ((DerefOf (SCLK [Zero]) == One))
                {
                    Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                    Local1 &= 0xFF9FFFFF
                    \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                }

                If ((DerefOf (WAKG [Zero]) != Zero))
                {
                    If ((DerefOf (WAKG [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                        Local1 &= 0xFFFFFBFF
                        \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                    }
                }

                If ((DerefOf (PWRG [Zero]) == One))
                {
                    If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != DerefOf (PWRG [
                        0x03])))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), DerefOf (PWRG [0x03]))
                        Sleep (0x64)
                    }
                }

                If ((VD02 != 0xFFFF))
                {
                    \_SB.SGOV (DerefOf (RSTG [0x02]), DerefOf (RSTG [0x03]))
                }

                BDQA = Zero
                BPLL = Zero
                L23R = One
                Sleep (0x10)
                Local0 = Zero
                While (L23R)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Name (PCIA, Zero)
                Switch (ToInteger (SLOT))
                {
                    Case (One)
                    {
                        Local3 = (0x07 & RPA1) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA1) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x02)
                    {
                        Local3 = (0x07 & RPA2) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA2) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x03)
                    {
                        Local3 = (0x07 & RPA3) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA3) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x04)
                    {
                        Local3 = (0x07 & RPA4) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA4) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x05)
                    {
                        Local3 = (0x07 & RPA5) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA5) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x06)
                    {
                        Local3 = (0x07 & RPA6) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA6) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP02.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Default
                    {
                    }

                }

                OperationRegion (PX02, SystemMemory, PCIA, 0x0380)
                Field (PX02, AnyAcc, NoLock, Preserve)
                {
                    VDID,   16, 
                    Offset (0x50), 
                    L0SE,   1, 
                        ,   3, 
                    LDIS,   1, 
                    Offset (0xE2), 
                        ,   2, 
                    L23E,   1, 
                    L23R,   1, 
                    Offset (0xF4), 
                        ,   10, 
                    BPLL,   1, 
                    Offset (0x324), 
                        ,   3, 
                    LEDM,   1, 
                    Offset (0x338), 
                        ,   26, 
                    BDQA,   1
                }

                L23E = One
                Sleep (0x10)
                Local0 = Zero
                While (L23E)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }

                BDQA = One
                BPLL = One
                If ((DerefOf (WAKG [Zero]) != Zero))
                {
                    If ((DerefOf (WAKG [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                        Local1 |= 0x0400
                        \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                    }
                }

                Divide (LNRD, 0x03E8, Local0, Local1)
                Sleep (Local1)
                If ((VDID != 0xFFFF))
                {
                    If ((DerefOf (RSTG [Zero]) != Zero))
                    {
                        If ((DerefOf (RSTG [Zero]) == One))
                        {
                            \_SB.SGOV (DerefOf (RSTG [0x02]), (DerefOf (RSTG [0x03]) ^ 
                                One))
                        }
                    }
                }

                If ((DerefOf (SCLK [Zero]) == One))
                {
                    Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                    Local1 &= 0xFF9FFFFF
                    Local1 |= 0x00400000
                    \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                }

                If ((DerefOf (PWRG [Zero]) == One))
                {
                    Local0 = ~DerefOf (PWRG [0x03])
                    If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != Local0))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), Local0)
                    }
                }
            }
        }

        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            PXP
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            PXP
        })
        Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
        {
            Return (0x02)
        }

        Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
        {
            Return (0x03)
        }

        Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
        {
            Return (0x02)
        }

        Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
        {
            Return (0x03)
        }
    }

    If ((HGEN == Zero))
    {
        Scope (\_SB.PCI0.RP03)
        {
            Name (PCA3, Zero)
            Name (SLOT, 0x03)
            Name (RSTG, Package (0x04)
            {
                One, 
                Zero, 
                0x00C509D0, 
                One
            })
            Name (PWRG, Package (0x04)
            {
                One, 
                Zero, 
                0x00C509A0, 
                One
            })
            Name (WAKG, Package (0x04)
            {
                Zero, 
                Zero, 
                0x00C50880, 
                One
            })
            Name (SCLK, Package (0x03)
            {
                Zero, 
                0x00C508C0, 
                Zero
            })
            Name (WKEN, Zero)
            Name (LNRD, Zero)
            Method (UPRD, 1, Serialized)
            {
                If ((Arg0 <= 0x2710))
                {
                    LNRD = Arg0
                }

                Return (LNRD) /* \_SB_.PCI0.RP03.LNRD */
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                Return (0x04)
            }

            Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
            {
                If (Arg1)
                {
                    WKEN = Zero
                }
                ElseIf ((Arg0 && Arg2))
                {
                    WKEN = One
                }
                Else
                {
                    WKEN = Zero
                }
            }

            PowerResource (PXP, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((DerefOf (PWRG [Zero]) != Zero))
                    {
                        If ((DerefOf (PWRG [Zero]) == One))
                        {
                            If ((\_SB.GGOV (DerefOf (PWRG [0x02])) == DerefOf (PWRG [0x03]
                                )))
                            {
                                Return (One)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    If ((DerefOf (RSTG [Zero]) != Zero))
                    {
                        If ((DerefOf (RSTG [Zero]) == One))
                        {
                            If ((\_SB.GGOV (DerefOf (RSTG [0x02])) == DerefOf (RSTG [0x03]
                                )))
                            {
                                Return (One)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }

                    Return (Zero)
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    Name (PCIA, Zero)
                    If ((SLOT == One))
                    {
                        Local3 = (0x07 & RPA1) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA1) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._ON_.PCIA */
                        PCIA |= Local3
                        PON (PCIA)
                    }
                    ElseIf ((SLOT == 0x02))
                    {
                        Local3 = (0x07 & RPA2) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA2) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._ON_.PCIA */
                        PCIA |= Local3
                        PON (PCIA)
                    }
                    ElseIf ((SLOT == 0x03))
                    {
                        Local3 = (0x07 & RPA3) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA3) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._ON_.PCIA */
                        PCIA |= Local3
                        PON (PCIA)
                    }
                    ElseIf ((SLOT == 0x04))
                    {
                        Local3 = (0x07 & RPA4) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA4) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._ON_.PCIA */
                        PCIA |= Local3
                        PON (PCIA)
                    }
                    ElseIf ((SLOT == 0x05))
                    {
                        Local3 = (0x07 & RPA5) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA5) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._ON_.PCIA */
                        PCIA |= Local3
                        PON (PCIA)
                    }
                    ElseIf ((SLOT == 0x06))
                    {
                        Local3 = (0x07 & RPA6) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA6) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._ON_.PCIA */
                        PCIA |= Local3
                        PON (PCIA)
                    }
                }

                Method (PON, 1, Serialized)
                {
                    OperationRegion (PX02, SystemMemory, Arg0, 0x0380)
                    Field (PX02, AnyAcc, NoLock, Preserve)
                    {
                        VD02,   32, 
                        Offset (0x50), 
                        L0SE,   1, 
                            ,   3, 
                        LDIS,   1, 
                        Offset (0x52), 
                            ,   13, 
                        LASX,   1, 
                        Offset (0xE2), 
                            ,   2, 
                        L23E,   1, 
                        L23R,   1, 
                        Offset (0xF4), 
                            ,   10, 
                        BPLL,   1, 
                        Offset (0x324), 
                            ,   3, 
                        LEDM,   1, 
                        Offset (0x338), 
                            ,   26, 
                        BDQA,   1
                    }

                    If ((DerefOf (SCLK [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                        Local1 &= 0xFF9FFFFF
                        \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                    }

                    If ((DerefOf (WAKG [Zero]) != Zero))
                    {
                        If ((DerefOf (WAKG [Zero]) == One))
                        {
                            Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                            Local1 &= 0xFFFFFBFF
                            \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                        }
                    }

                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != DerefOf (PWRG [
                            0x03])))
                        {
                            \_SB.SGOV (DerefOf (PWRG [0x02]), DerefOf (PWRG [0x03]))
                            Sleep (0x64)
                        }
                    }

                    If ((VD02 != 0xFFFF))
                    {
                        \_SB.SGOV (DerefOf (RSTG [0x02]), DerefOf (RSTG [0x03]))
                    }

                    BDQA = Zero
                    BPLL = Zero
                    L23R = One
                    Sleep (0x10)
                    Local0 = Zero
                    While (L23R)
                    {
                        If ((Local0 > 0x04))
                        {
                            Break
                        }

                        Sleep (0x10)
                        Local0++
                    }
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    Name (PCIA, Zero)
                    Switch (ToInteger (SLOT))
                    {
                        Case (One)
                        {
                            Local3 = (0x07 & RPA1) /* External reference */
                            Local3 <<= 0x0C
                            PCIA = (0xFFFF0000 & RPA1) /* External reference */
                            PCIA >>= One
                            PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._OFF.PCIA */
                            PCIA |= Local3
                        }
                        Case (0x02)
                        {
                            Local3 = (0x07 & RPA2) /* External reference */
                            Local3 <<= 0x0C
                            PCIA = (0xFFFF0000 & RPA2) /* External reference */
                            PCIA >>= One
                            PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._OFF.PCIA */
                            PCIA |= Local3
                        }
                        Case (0x03)
                        {
                            Local3 = (0x07 & RPA3) /* External reference */
                            Local3 <<= 0x0C
                            PCIA = (0xFFFF0000 & RPA3) /* External reference */
                            PCIA >>= One
                            PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._OFF.PCIA */
                            PCIA |= Local3
                        }
                        Case (0x04)
                        {
                            Local3 = (0x07 & RPA4) /* External reference */
                            Local3 <<= 0x0C
                            PCIA = (0xFFFF0000 & RPA4) /* External reference */
                            PCIA >>= One
                            PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._OFF.PCIA */
                            PCIA |= Local3
                        }
                        Case (0x05)
                        {
                            Local3 = (0x07 & RPA5) /* External reference */
                            Local3 <<= 0x0C
                            PCIA = (0xFFFF0000 & RPA5) /* External reference */
                            PCIA >>= One
                            PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._OFF.PCIA */
                            PCIA |= Local3
                        }
                        Case (0x06)
                        {
                            Local3 = (0x07 & RPA6) /* External reference */
                            Local3 <<= 0x0C
                            PCIA = (0xFFFF0000 & RPA6) /* External reference */
                            PCIA >>= One
                            PCIA |= 0xE0000000 /* \_SB_.PCI0.RP03.PXP_._OFF.PCIA */
                            PCIA |= Local3
                        }
                        Default
                        {
                        }

                    }

                    OperationRegion (PX02, SystemMemory, PCIA, 0x0380)
                    Field (PX02, AnyAcc, NoLock, Preserve)
                    {
                        VDID,   16, 
                        Offset (0x50), 
                        L0SE,   1, 
                            ,   3, 
                        LDIS,   1, 
                        Offset (0xE2), 
                            ,   2, 
                        L23E,   1, 
                        L23R,   1, 
                        Offset (0xF4), 
                            ,   10, 
                        BPLL,   1, 
                        Offset (0x324), 
                            ,   3, 
                        LEDM,   1, 
                        Offset (0x338), 
                            ,   26, 
                        BDQA,   1
                    }

                    L23E = One
                    Sleep (0x10)
                    Local0 = Zero
                    While (L23E)
                    {
                        If ((Local0 > 0x04))
                        {
                            Break
                        }

                        Sleep (0x10)
                        Local0++
                    }

                    BDQA = One
                    BPLL = One
                    If ((DerefOf (WAKG [Zero]) != Zero))
                    {
                        If ((DerefOf (WAKG [Zero]) == One))
                        {
                            Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                            Local1 |= 0x0400
                            \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                        }
                    }

                    Divide (LNRD, 0x03E8, Local0, Local1)
                    Sleep (Local1)
                    If ((VDID != 0xFFFF))
                    {
                        If ((DerefOf (RSTG [Zero]) != Zero))
                        {
                            If ((DerefOf (RSTG [Zero]) == One))
                            {
                                \_SB.SGOV (DerefOf (RSTG [0x02]), (DerefOf (RSTG [0x03]) ^ 
                                    One))
                            }
                        }
                    }

                    If ((DerefOf (SCLK [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                        Local1 &= 0xFF9FFFFF
                        Local1 |= 0x00400000
                        \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                    }

                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        Local0 = ~DerefOf (PWRG [0x03])
                        If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != Local0))
                        {
                            \_SB.SGOV (DerefOf (PWRG [0x02]), Local0)
                        }
                    }
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PXP
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PXP
            })
            Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
            {
                Return (0x03)
            }

            Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
            {
                Return (0x03)
            }
        }
    }

    Scope (\_SB.PCI0.RP04)
    {
        Name (PCA4, Zero)
        Name (SLOT, 0x04)
        Name (RSTG, Package (0x04)
        {
            Zero, 
            Zero, 
            Zero, 
            One
        })
        Name (PWRG, Package (0x04)
        {
            Zero, 
            Zero, 
            Zero, 
            One
        })
        Name (WAKG, Package (0x04)
        {
            Zero, 
            Zero, 
            Zero, 
            One
        })
        Name (SCLK, Package (0x03)
        {
            Zero, 
            Zero, 
            Zero
        })
        Name (WKEN, Zero)
        Name (LNRD, Zero)
        Method (UPRD, 1, Serialized)
        {
            If ((Arg0 <= 0x2710))
            {
                LNRD = Arg0
            }

            Return (LNRD) /* \_SB_.PCI0.RP04.LNRD */
        }

        Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
        {
            Return (0x04)
        }

        Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
        {
            If (Arg1)
            {
                WKEN = Zero
            }
            ElseIf ((Arg0 && Arg2))
            {
                WKEN = One
            }
            Else
            {
                WKEN = Zero
            }
        }

        PowerResource (PXP, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (PWRG [0x02])) == DerefOf (PWRG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                If ((DerefOf (RSTG [Zero]) != Zero))
                {
                    If ((DerefOf (RSTG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (RSTG [0x02])) == DerefOf (RSTG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Return (Zero)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Name (PCIA, Zero)
                If ((SLOT == One))
                {
                    Local3 = (0x07 & RPA1) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA1) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x02))
                {
                    Local3 = (0x07 & RPA2) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA2) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x03))
                {
                    Local3 = (0x07 & RPA3) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA3) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x04))
                {
                    Local3 = (0x07 & RPA4) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA4) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x05))
                {
                    Local3 = (0x07 & RPA5) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA5) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x06))
                {
                    Local3 = (0x07 & RPA6) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA6) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
            }

            Method (PON, 1, Serialized)
            {
                OperationRegion (PX02, SystemMemory, Arg0, 0x0380)
                Field (PX02, AnyAcc, NoLock, Preserve)
                {
                    VD02,   32, 
                    Offset (0x50), 
                    L0SE,   1, 
                        ,   3, 
                    LDIS,   1, 
                    Offset (0x52), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0xE2), 
                        ,   2, 
                    L23E,   1, 
                    L23R,   1, 
                    Offset (0xF4), 
                        ,   10, 
                    BPLL,   1, 
                    Offset (0x324), 
                        ,   3, 
                    LEDM,   1, 
                    Offset (0x338), 
                        ,   26, 
                    BDQA,   1
                }

                If ((DerefOf (SCLK [Zero]) == One))
                {
                    Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                    Local1 &= 0xFF9FFFFF
                    \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                }

                If ((DerefOf (WAKG [Zero]) != Zero))
                {
                    If ((DerefOf (WAKG [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                        Local1 &= 0xFFFFFBFF
                        \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                    }
                }

                If ((DerefOf (PWRG [Zero]) == One))
                {
                    If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != DerefOf (PWRG [
                        0x03])))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), DerefOf (PWRG [0x03]))
                        Sleep (0x64)
                    }
                }

                If ((VD02 != 0xFFFF))
                {
                    \_SB.SGOV (DerefOf (RSTG [0x02]), DerefOf (RSTG [0x03]))
                }

                BDQA = Zero
                BPLL = Zero
                L23R = One
                Sleep (0x10)
                Local0 = Zero
                While (L23R)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Name (PCIA, Zero)
                Switch (ToInteger (SLOT))
                {
                    Case (One)
                    {
                        Local3 = (0x07 & RPA1) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA1) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x02)
                    {
                        Local3 = (0x07 & RPA2) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA2) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x03)
                    {
                        Local3 = (0x07 & RPA3) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA3) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x04)
                    {
                        Local3 = (0x07 & RPA4) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA4) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x05)
                    {
                        Local3 = (0x07 & RPA5) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA5) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x06)
                    {
                        Local3 = (0x07 & RPA6) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA6) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP04.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Default
                    {
                    }

                }

                OperationRegion (PX02, SystemMemory, PCIA, 0x0380)
                Field (PX02, AnyAcc, NoLock, Preserve)
                {
                    VDID,   16, 
                    Offset (0x50), 
                    L0SE,   1, 
                        ,   3, 
                    LDIS,   1, 
                    Offset (0xE2), 
                        ,   2, 
                    L23E,   1, 
                    L23R,   1, 
                    Offset (0xF4), 
                        ,   10, 
                    BPLL,   1, 
                    Offset (0x324), 
                        ,   3, 
                    LEDM,   1, 
                    Offset (0x338), 
                        ,   26, 
                    BDQA,   1
                }

                L23E = One
                Sleep (0x10)
                Local0 = Zero
                While (L23E)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }

                BDQA = One
                BPLL = One
                If ((DerefOf (WAKG [Zero]) != Zero))
                {
                    If ((DerefOf (WAKG [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                        Local1 |= 0x0400
                        \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                    }
                }

                Divide (LNRD, 0x03E8, Local0, Local1)
                Sleep (Local1)
                If ((VDID != 0xFFFF))
                {
                    If ((DerefOf (RSTG [Zero]) != Zero))
                    {
                        If ((DerefOf (RSTG [Zero]) == One))
                        {
                            \_SB.SGOV (DerefOf (RSTG [0x02]), (DerefOf (RSTG [0x03]) ^ 
                                One))
                        }
                    }
                }

                If ((DerefOf (SCLK [Zero]) == One))
                {
                    Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                    Local1 &= 0xFF9FFFFF
                    Local1 |= 0x00400000
                    \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                }

                If ((DerefOf (PWRG [Zero]) == One))
                {
                    Local0 = ~DerefOf (PWRG [0x03])
                    If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != Local0))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), Local0)
                    }
                }
            }
        }

        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            PXP
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            PXP
        })
        Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
        {
            Return (0x02)
        }

        Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
        {
            Return (0x03)
        }

        Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
        {
            Return (0x02)
        }

        Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
        {
            Return (0x03)
        }
    }

    Scope (\_SB.PCI0.RP05)
    {
        Name (PCA5, Zero)
        Name (SLOT, 0x05)
        Name (RSTG, Package (0x04)
        {
            One, 
            Zero, 
            0x00C806D0, 
            One
        })
        Name (PWRG, Package (0x04)
        {
            One, 
            Zero, 
            0x00C40AF0, 
            One
        })
        Name (WAKG, Package (0x04)
        {
            Zero, 
            Zero, 
            0x00C50890, 
            One
        })
        Name (SCLK, Package (0x03)
        {
            Zero, 
            0x00C508D0, 
            Zero
        })
        Name (WKEN, Zero)
        Name (LNRD, Zero)
        Method (UPRD, 1, Serialized)
        {
            If ((Arg0 <= 0x2710))
            {
                LNRD = Arg0
            }

            Return (LNRD) /* \_SB_.PCI0.RP05.LNRD */
        }

        Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
        {
            Return (0x04)
        }

        Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
        {
            If (Arg1)
            {
                WKEN = Zero
            }
            ElseIf ((Arg0 && Arg2))
            {
                WKEN = One
            }
            Else
            {
                WKEN = Zero
            }
        }

        PowerResource (PXP, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (PWRG [0x02])) == DerefOf (PWRG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                If ((DerefOf (RSTG [Zero]) != Zero))
                {
                    If ((DerefOf (RSTG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (RSTG [0x02])) == DerefOf (RSTG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Return (Zero)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Name (PCIA, Zero)
                If ((SLOT == One))
                {
                    Local3 = (0x07 & RPA1) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA1) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x02))
                {
                    Local3 = (0x07 & RPA2) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA2) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x03))
                {
                    Local3 = (0x07 & RPA3) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA3) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x04))
                {
                    Local3 = (0x07 & RPA4) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA4) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x05))
                {
                    Local3 = (0x07 & RPA5) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA5) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x06))
                {
                    Local3 = (0x07 & RPA6) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA6) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
            }

            Method (PON, 1, Serialized)
            {
                OperationRegion (PX02, SystemMemory, Arg0, 0x0380)
                Field (PX02, AnyAcc, NoLock, Preserve)
                {
                    VD02,   32, 
                    Offset (0x50), 
                    L0SE,   1, 
                        ,   3, 
                    LDIS,   1, 
                    Offset (0x52), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0xE2), 
                        ,   2, 
                    L23E,   1, 
                    L23R,   1, 
                    Offset (0xF4), 
                        ,   10, 
                    BPLL,   1, 
                    Offset (0x324), 
                        ,   3, 
                    LEDM,   1, 
                    Offset (0x338), 
                        ,   26, 
                    BDQA,   1
                }

                If ((DerefOf (SCLK [Zero]) == One))
                {
                    Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                    Local1 &= 0xFF9FFFFF
                    \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                }

                If ((DerefOf (WAKG [Zero]) != Zero))
                {
                    If ((DerefOf (WAKG [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                        Local1 &= 0xFFFFFBFF
                        \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                    }
                }

                If ((DerefOf (PWRG [Zero]) == One))
                {
                    If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != DerefOf (PWRG [
                        0x03])))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), DerefOf (PWRG [0x03]))
                        Sleep (0x64)
                    }
                }

                If ((VD02 != 0xFFFF))
                {
                    \_SB.SGOV (DerefOf (RSTG [0x02]), DerefOf (RSTG [0x03]))
                }

                BDQA = Zero
                BPLL = Zero
                L23R = One
                Sleep (0x10)
                Local0 = Zero
                While (L23R)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Name (PCIA, Zero)
                Switch (ToInteger (SLOT))
                {
                    Case (One)
                    {
                        Local3 = (0x07 & RPA1) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA1) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x02)
                    {
                        Local3 = (0x07 & RPA2) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA2) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x03)
                    {
                        Local3 = (0x07 & RPA3) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA3) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x04)
                    {
                        Local3 = (0x07 & RPA4) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA4) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x05)
                    {
                        Local3 = (0x07 & RPA5) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA5) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x06)
                    {
                        Local3 = (0x07 & RPA6) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA6) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP05.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Default
                    {
                    }

                }

                OperationRegion (PX02, SystemMemory, PCIA, 0x0380)
                Field (PX02, AnyAcc, NoLock, Preserve)
                {
                    VDID,   16, 
                    Offset (0x50), 
                    L0SE,   1, 
                        ,   3, 
                    LDIS,   1, 
                    Offset (0xE2), 
                        ,   2, 
                    L23E,   1, 
                    L23R,   1, 
                    Offset (0xF4), 
                        ,   10, 
                    BPLL,   1, 
                    Offset (0x324), 
                        ,   3, 
                    LEDM,   1, 
                    Offset (0x338), 
                        ,   26, 
                    BDQA,   1
                }

                L23E = One
                Sleep (0x10)
                Local0 = Zero
                While (L23E)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }

                BDQA = One
                BPLL = One
                If ((DerefOf (WAKG [Zero]) != Zero))
                {
                    If ((DerefOf (WAKG [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                        Local1 |= 0x0400
                        \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                    }
                }

                Divide (LNRD, 0x03E8, Local0, Local1)
                Sleep (Local1)
                If ((VDID != 0xFFFF))
                {
                    If ((DerefOf (RSTG [Zero]) != Zero))
                    {
                        If ((DerefOf (RSTG [Zero]) == One))
                        {
                            \_SB.SGOV (DerefOf (RSTG [0x02]), (DerefOf (RSTG [0x03]) ^ 
                                One))
                        }
                    }
                }

                If ((DerefOf (SCLK [Zero]) == One))
                {
                    Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                    Local1 &= 0xFF9FFFFF
                    Local1 |= 0x00400000
                    \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                }

                If ((DerefOf (PWRG [Zero]) == One))
                {
                    Local0 = ~DerefOf (PWRG [0x03])
                    If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != Local0))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), Local0)
                    }
                }
            }
        }

        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            PXP
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            PXP
        })
        Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
        {
            Return (0x02)
        }

        Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
        {
            Return (0x03)
        }

        Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
        {
            Return (0x02)
        }

        Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
        {
            Return (0x03)
        }
    }

    Scope (\_SB.PCI0.RP06)
    {
        Name (PCA6, Zero)
        Name (SLOT, 0x06)
        Name (RSTG, Package (0x04)
        {
            One, 
            Zero, 
            0x00C509D0, 
            One
        })
        Name (PWRG, Package (0x04)
        {
            Zero, 
            Zero, 
            Zero, 
            Zero
        })
        Name (WAKG, Package (0x04)
        {
            Zero, 
            Zero, 
            0x00C50880, 
            One
        })
        Name (SCLK, Package (0x03)
        {
            Zero, 
            0x00C508C0, 
            Zero
        })
        Name (WKEN, Zero)
        Name (LNRD, Zero)
        Method (UPRD, 1, Serialized)
        {
            If ((Arg0 <= 0x2710))
            {
                LNRD = Arg0
            }

            Return (LNRD) /* \_SB_.PCI0.RP06.LNRD */
        }

        Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
        {
            Return (0x04)
        }

        Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
        {
            If (Arg1)
            {
                WKEN = Zero
            }
            ElseIf ((Arg0 && Arg2))
            {
                WKEN = One
            }
            Else
            {
                WKEN = Zero
            }
        }

        PowerResource (PXP, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (PWRG [0x02])) == DerefOf (PWRG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                If ((DerefOf (RSTG [Zero]) != Zero))
                {
                    If ((DerefOf (RSTG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (RSTG [0x02])) == DerefOf (RSTG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Return (Zero)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Name (PCIA, Zero)
                If ((SLOT == One))
                {
                    Local3 = (0x07 & RPA1) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA1) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x02))
                {
                    Local3 = (0x07 & RPA2) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA2) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x03))
                {
                    Local3 = (0x07 & RPA3) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA3) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x04))
                {
                    Local3 = (0x07 & RPA4) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA4) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x05))
                {
                    Local3 = (0x07 & RPA5) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA5) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
                ElseIf ((SLOT == 0x06))
                {
                    Local3 = (0x07 & RPA6) /* External reference */
                    Local3 <<= 0x0C
                    PCIA = (0xFFFF0000 & RPA6) /* External reference */
                    PCIA >>= One
                    PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._ON_.PCIA */
                    PCIA |= Local3
                    PON (PCIA)
                }
            }

            Method (PON, 1, Serialized)
            {
                OperationRegion (PX02, SystemMemory, Arg0, 0x0380)
                Field (PX02, AnyAcc, NoLock, Preserve)
                {
                    VD02,   32, 
                    Offset (0x50), 
                    L0SE,   1, 
                        ,   3, 
                    LDIS,   1, 
                    Offset (0x52), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0xE2), 
                        ,   2, 
                    L23E,   1, 
                    L23R,   1, 
                    Offset (0xF4), 
                        ,   10, 
                    BPLL,   1, 
                    Offset (0x324), 
                        ,   3, 
                    LEDM,   1, 
                    Offset (0x338), 
                        ,   26, 
                    BDQA,   1
                }

                If ((DerefOf (SCLK [Zero]) == One))
                {
                    Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                    Local1 &= 0xFF9FFFFF
                    \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                }

                If ((DerefOf (WAKG [Zero]) != Zero))
                {
                    If ((DerefOf (WAKG [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                        Local1 &= 0xFFFFFBFF
                        \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                    }
                }

                If ((DerefOf (PWRG [Zero]) == One))
                {
                    If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != DerefOf (PWRG [
                        0x03])))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), DerefOf (PWRG [0x03]))
                        Sleep (0x64)
                    }
                }

                If ((VD02 != 0xFFFF))
                {
                    \_SB.SGOV (DerefOf (RSTG [0x02]), DerefOf (RSTG [0x03]))
                }

                BDQA = Zero
                BPLL = Zero
                L23R = One
                Sleep (0x10)
                Local0 = Zero
                While (L23R)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Name (PCIA, Zero)
                Switch (ToInteger (SLOT))
                {
                    Case (One)
                    {
                        Local3 = (0x07 & RPA1) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA1) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x02)
                    {
                        Local3 = (0x07 & RPA2) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA2) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x03)
                    {
                        Local3 = (0x07 & RPA3) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA3) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x04)
                    {
                        Local3 = (0x07 & RPA4) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA4) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x05)
                    {
                        Local3 = (0x07 & RPA5) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA5) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Case (0x06)
                    {
                        Local3 = (0x07 & RPA6) /* External reference */
                        Local3 <<= 0x0C
                        PCIA = (0xFFFF0000 & RPA6) /* External reference */
                        PCIA >>= One
                        PCIA |= 0xE0000000 /* \_SB_.PCI0.RP06.PXP_._OFF.PCIA */
                        PCIA |= Local3
                    }
                    Default
                    {
                    }

                }

                OperationRegion (PX02, SystemMemory, PCIA, 0x0380)
                Field (PX02, AnyAcc, NoLock, Preserve)
                {
                    VDID,   16, 
                    Offset (0x50), 
                    L0SE,   1, 
                        ,   3, 
                    LDIS,   1, 
                    Offset (0xE2), 
                        ,   2, 
                    L23E,   1, 
                    L23R,   1, 
                    Offset (0xF4), 
                        ,   10, 
                    BPLL,   1, 
                    Offset (0x324), 
                        ,   3, 
                    LEDM,   1, 
                    Offset (0x338), 
                        ,   26, 
                    BDQA,   1
                }

                L23E = One
                Sleep (0x10)
                Local0 = Zero
                While (L23E)
                {
                    If ((Local0 > 0x04))
                    {
                        Break
                    }

                    Sleep (0x10)
                    Local0++
                }

                BDQA = One
                BPLL = One
                If ((DerefOf (WAKG [Zero]) != Zero))
                {
                    If ((DerefOf (WAKG [Zero]) == One))
                    {
                        Local1 = \_SB.GPC0 (DerefOf (WAKG [0x02]))
                        Local1 |= 0x0400
                        \_SB.SPC0 (DerefOf (WAKG [0x02]), Local1)
                    }
                }

                Divide (LNRD, 0x03E8, Local0, Local1)
                Sleep (Local1)
                If ((VDID != 0xFFFF))
                {
                    If ((DerefOf (RSTG [Zero]) != Zero))
                    {
                        If ((DerefOf (RSTG [Zero]) == One))
                        {
                            \_SB.SGOV (DerefOf (RSTG [0x02]), (DerefOf (RSTG [0x03]) ^ 
                                One))
                        }
                    }
                }

                If ((DerefOf (SCLK [Zero]) == One))
                {
                    Local1 = \_SB.GPC0 (DerefOf (SCLK [One]))
                    Local1 &= 0xFF9FFFFF
                    Local1 |= 0x00400000
                    \_SB.SPC0 (DerefOf (SCLK [One]), Local1)
                }

                If ((DerefOf (PWRG [Zero]) == One))
                {
                    Local0 = ~DerefOf (PWRG [0x03])
                    If ((\_SB.GGOV (DerefOf (PWRG [0x02])) != Local0))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), Local0)
                    }
                }
            }
        }

        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            PXP
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            PXP
        })
        Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
        {
            Return (0x02)
        }

        Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
        {
            Return (0x03)
        }

        Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
        {
            Return (0x02)
        }

        Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
        {
            Return (0x03)
        }
    }

    Scope (\_SB.PCI0.SATA)
    {
        OperationRegion (PMCS, PCI_Config, 0x74, 0x04)
        Field (PMCS, WordAcc, NoLock, Preserve)
        {
            PMSR,   32
        }

        Method (_PS0, 0, Serialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, Serialized)  // _PS3: Power State 3
        {
            Local0 = PMSR /* \_SB_.PCI0.SATA.PMSR */
            Local0 &= One
        }

        OperationRegion (SMIO, PCI_Config, 0x24, 0x04)
        Field (SMIO, AnyAcc, NoLock, Preserve)
        {
            MBR6,   32
        }

        Scope (PRT0)
        {
            Name (PORT, Zero)
            Name (PBAR, 0x0118)
            Name (PWRG, Package (0x04)
            {
                Zero, 
                Zero, 
                0x00C509E0, 
                One
            })
            Name (WKEN, Zero)
            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
            }

            Method (_PS3, 0, Serialized)  // _PS3: Power State 3
            {
            }

            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (Package (0x02)
                {
                    0x41, 
                    0x04
                })
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                Return (0x04)
            }

            Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
            {
                If (Arg1)
                {
                    WKEN = Zero
                }
                ElseIf ((Arg0 && Arg2))
                {
                    WKEN = One
                }
                Else
                {
                    WKEN = Zero
                }
            }

            Method (_PR0, 0, NotSerialized)  // _PR0: Power Resources for D0
            {
                If (((\OSYS >= 0x07DF) && (\EMOD == One)))
                {
                    If (CondRefOf (\_SB.MODS))
                    {
                        Return (Package (0x01)
                        {
                            \_SB.MODS
                        })
                    }
                }
                Else
                {
                    If ((DerefOf (PWRG [Zero]) == Zero))
                    {
                        Return (Package (0x00){})
                    }

                    If (CondRefOf (SPPR))
                    {
                        Return (Package (0x01)
                        {
                            SPPR
                        })
                    }
                }

                Return (Package (0x00){})
            }

            Method (_PR3, 0, NotSerialized)  // _PR3: Power Resources for D3hot
            {
                If (((\OSYS >= 0x07DF) && (\EMOD == One)))
                {
                    If (CondRefOf (\_SB.MODS))
                    {
                        Return (Package (0x01)
                        {
                            \_SB.MODS
                        })
                    }
                }
                Else
                {
                    If ((DerefOf (PWRG [Zero]) == Zero))
                    {
                        Return (Package (0x00){})
                    }

                    If (CondRefOf (SPPR))
                    {
                        Return (Package (0x01)
                        {
                            SPPR
                        })
                    }
                }

                Return (Package (0x00){})
            }

            PowerResource (SPPR, 0x00, 0x0000)
            {
                Name (_STA, One)  // _STA: Status
                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    If ((\EMOD == One)){}
                    Else
                    {
                        _STA = One
                        ZPGE = Zero
                        SPON ()
                        Sleep (0x10)
                    }
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                    If ((\EMOD == One)){}
                    Else
                    {
                        SPOF ()
                        _STA = Zero
                        ZPGE = One
                    }
                }
            }

            Name (OFTM, Zero)
            Method (SPSA, 0, NotSerialized)
            {
                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (PWRG [0x02])) == DerefOf (PWRG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Return (Zero)
            }

            Method (SPON, 0, NotSerialized)
            {
                If ((^OFTM != Zero))
                {
                    Local0 = ((Timer - ^OFTM) / 0x2710)
                    ^OFTM = Zero
                    If ((Local0 < 0x32))
                    {
                        Sleep ((0x32 - Local0))
                    }
                }

                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), DerefOf (PWRG [0x03]))
                    }
                }
            }

            Method (SPOF, 0, NotSerialized)
            {
                Local0 = (\_SB.PCI0.SATA.MBR6 + PBAR) /* \_SB_.PCI0.SATA.PRT0.PBAR */
                If ((S0ID == One))
                {
                    OperationRegion (PSTS, SystemMemory, Local0, 0x18)
                    Field (PSTS, DWordAcc, NoLock, Preserve)
                    {
                        CMST,   1, 
                        CSUD,   1, 
                            ,   2, 
                        CFRE,   1, 
                        Offset (0x10), 
                        SDET,   4, 
                        Offset (0x14), 
                        CDET,   4
                    }

                    If (((SDET == One) || (SDET == 0x03)))
                    {
                        CMST = Zero
                        CFRE = Zero
                        CSUD = Zero
                        CDET = 0x04
                        Sleep (0x10)
                        While ((SDET != 0x04))
                        {
                            Sleep (0x10)
                        }
                    }
                }

                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), (DerefOf (PWRG [0x03]) ^ 
                            One))
                    }
                }

                ^OFTM = Timer
            }
        }

        Scope (PRT1)
        {
            Name (PORT, One)
            Name (PBAR, 0x0198)
            Name (PWRG, Package (0x04)
            {
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (WKEN, Zero)
            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
            }

            Method (_PS3, 0, Serialized)  // _PS3: Power State 3
            {
            }

            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (Package (0x02)
                {
                    0x41, 
                    0x04
                })
            }

            Method (_S0W, 0, NotSerialized)  // _S0W: S0 Device Wake State
            {
                Return (0x04)
            }

            Method (_DSW, 3, NotSerialized)  // _DSW: Device Sleep Wake
            {
                If (Arg1)
                {
                    WKEN = Zero
                }
                ElseIf ((Arg0 && Arg2))
                {
                    WKEN = One
                }
                Else
                {
                    WKEN = Zero
                }
            }

            Method (_PR0, 0, NotSerialized)  // _PR0: Power Resources for D0
            {
                If (((\OSYS >= 0x07DF) && (\EMOD == One)))
                {
                    If (CondRefOf (\_SB.MODS))
                    {
                        Return (Package (0x01)
                        {
                            \_SB.MODS
                        })
                    }
                }
                Else
                {
                    If ((DerefOf (PWRG [Zero]) == Zero))
                    {
                        Return (Package (0x00){})
                    }

                    If (CondRefOf (SPPR))
                    {
                        Return (Package (0x01)
                        {
                            SPPR
                        })
                    }
                }

                Return (Package (0x00){})
            }

            Method (_PR3, 0, NotSerialized)  // _PR3: Power Resources for D3hot
            {
                If (((\OSYS >= 0x07DF) && (\EMOD == One)))
                {
                    If (CondRefOf (\_SB.MODS))
                    {
                        Return (Package (0x01)
                        {
                            \_SB.MODS
                        })
                    }
                }
                Else
                {
                    If ((DerefOf (PWRG [Zero]) == Zero))
                    {
                        Return (Package (0x00){})
                    }

                    If (CondRefOf (SPPR))
                    {
                        Return (Package (0x01)
                        {
                            SPPR
                        })
                    }
                }

                Return (Package (0x00){})
            }

            PowerResource (SPPR, 0x00, 0x0000)
            {
                Name (_STA, One)  // _STA: Status
                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    If ((\EMOD == One)){}
                    Else
                    {
                        _STA = One
                        ZPGE = Zero
                        SPON ()
                        Sleep (0x10)
                    }
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                    If ((\EMOD == One)){}
                    Else
                    {
                        SPOF ()
                        _STA = Zero
                        ZPGE = One
                    }
                }
            }

            Name (OFTM, Zero)
            Method (SPSA, 0, NotSerialized)
            {
                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        If ((\_SB.GGOV (DerefOf (PWRG [0x02])) == DerefOf (PWRG [0x03]
                            )))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Return (Zero)
            }

            Method (SPON, 0, NotSerialized)
            {
                If ((^OFTM != Zero))
                {
                    Local0 = ((Timer - ^OFTM) / 0x2710)
                    ^OFTM = Zero
                    If ((Local0 < 0x32))
                    {
                        Sleep ((0x32 - Local0))
                    }
                }

                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), DerefOf (PWRG [0x03]))
                    }
                }
            }

            Method (SPOF, 0, NotSerialized)
            {
                Local0 = (\_SB.PCI0.SATA.MBR6 + PBAR) /* \_SB_.PCI0.SATA.PRT1.PBAR */
                If ((S0ID == One))
                {
                    OperationRegion (PSTS, SystemMemory, Local0, 0x18)
                    Field (PSTS, DWordAcc, NoLock, Preserve)
                    {
                        CMST,   1, 
                        CSUD,   1, 
                            ,   2, 
                        CFRE,   1, 
                        Offset (0x10), 
                        SDET,   4, 
                        Offset (0x14), 
                        CDET,   4
                    }

                    If (((SDET == One) || (SDET == 0x03)))
                    {
                        CMST = Zero
                        CFRE = Zero
                        CSUD = Zero
                        CDET = 0x04
                        Sleep (0x10)
                        While ((SDET != 0x04))
                        {
                            Sleep (0x10)
                        }
                    }
                }

                If ((DerefOf (PWRG [Zero]) != Zero))
                {
                    If ((DerefOf (PWRG [Zero]) == One))
                    {
                        \_SB.SGOV (DerefOf (PWRG [0x02]), (DerefOf (PWRG [0x03]) ^ 
                            One))
                    }
                }

                ^OFTM = Timer
            }
        }

        Name (DRV, Zero)
        Name (PWR, Zero)
        Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
        {
            If ((Arg0 == ToUUID ("e4db149b-fcfe-425b-a6d8-92357d78fc7f") /* SATA Controller */))
            {
                Switch (ToInteger (Arg2))
                {
                    Case (Zero)
                    {
                        If (((RCG0 & One) && One))
                        {
                            Return (0x03)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }
                    Case (One)
                    {
                        Return (Package (0x00){})
                    }
                    Case (0x02)
                    {
                        DRV = ToInteger (DerefOf (Arg3 [Zero]))
                        PWR = ToInteger (DerefOf (Arg3 [One]))
                        Switch (ToInteger (DRV))
                        {
                            Case (0xFFFF)
                            {
                                If (PWR)
                                {
                                    \_SB.PCI0.SATA.PRT0.SPPR._ON ()
                                }
                            }

                        }

                        Return (Zero)
                    }
                    Case (0x03)
                    {
                        DRV = ToInteger (DerefOf (Arg3 [Zero]))
                        Switch (ToInteger (DRV))
                        {
                            Case (0xFFFF)
                            {
                                Return (\_SB.PCI0.SATA.PRT0.SPPR._STA)
                            }
                            Case (0x0001FFFF)
                            {
                                Return (\_SB.PCI0.SATA.PRT1.SPPR._STA)
                            }
                            Default
                            {
                                Return (Ones)
                            }

                        }
                    }
                    Default
                    {
                        Return (Zero)
                    }

                }
            }
            Else
            {
                Return (Zero)
            }
        }
    }

    Scope (\_SB.PCI0.XHC.RHUB)
    {
        Scope (HS02)
        {
            Name (PORT, 0x02)
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                UPPR
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                UPPR
            })
            PowerResource (UPPR, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (One)
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                }
            }

            Method (_S0W, 0, Serialized)  // _S0W: S0 Device Wake State
            {
                Return (0x03)
            }

            Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
            {
                Return (0x03)
            }

            Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
            {
                Return (0x03)
            }
        }

        Scope (SS02)
        {
            Name (PORT, 0x0A)
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                UPPR
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                UPPR
            })
            PowerResource (UPPR, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (One)
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                }
            }

            Method (_S0W, 0, Serialized)  // _S0W: S0 Device Wake State
            {
                Return (0x03)
            }

            Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
            {
                Return (0x03)
            }

            Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
            {
                Return (0x03)
            }
        }

        Scope (HS04)
        {
            Name (PORT, 0x04)
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                UPPR
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                UPPR
            })
            PowerResource (UPPR, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (One)
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                }
            }

            Method (_S0W, 0, Serialized)  // _S0W: S0 Device Wake State
            {
                Return (0x03)
            }

            Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
            {
                Return (0x03)
            }

            Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
            {
                Return (0x03)
            }
        }

        Scope (SS04)
        {
            Name (PORT, 0x0C)
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                UPPR
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                UPPR
            })
            PowerResource (UPPR, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (One)
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                }
            }

            Method (_S0W, 0, Serialized)  // _S0W: S0 Device Wake State
            {
                Return (0x03)
            }

            Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
            {
                Return (0x03)
            }

            Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
            {
                Return (0x03)
            }
        }

        Scope (HS05)
        {
            Name (PORT, 0x05)
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                UPPR
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                UPPR
            })
            PowerResource (UPPR, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (One)
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                }
            }

            Method (_S0W, 0, Serialized)  // _S0W: S0 Device Wake State
            {
                Return (0x03)
            }

            Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
            {
                Return (0x03)
            }

            Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
            {
                Return (0x03)
            }
        }

        Scope (SS05)
        {
            Name (PORT, 0x0D)
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                UPPR
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                UPPR
            })
            PowerResource (UPPR, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (One)
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                }
            }

            Method (_S0W, 0, Serialized)  // _S0W: S0 Device Wake State
            {
                Return (0x03)
            }

            Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
            {
                Return (0x03)
            }

            Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
            {
                Return (0x03)
            }
        }

        Scope (HS07)
        {
            Name (PORT, 0x07)
            PowerResource (PX07, 0x00, 0x0000)
            {
                Name (WOFF, Zero)
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((\_SB.GGOV (0x00C90690) == One))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    If ((^WOFF != Zero))
                    {
                        Local0 = ((Timer - ^WOFF) / 0x2710)
                        If ((Local0 < 0x64))
                        {
                            Sleep ((0x64 - Local0))
                        }
                    }

                    \_SB.SGOV (0x00C90690, One)
                    \_SB.SGOV (0x00C90610, One)
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                    \_SB.SGOV (0x00C90610, Zero)
                    \_SB.SGOV (0x00C90690, Zero)
                    ^WOFF = Timer
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                PX07
            })
            Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
            {
                PX07
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                PX07
            })
            Device (MODM)
            {
                Name (_ADR, 0x07)  // _ADR: Address
                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    PX07
                })
                Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
                {
                    PX07
                })
                Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
                {
                    PX07
                })
            }

            Method (_S0W, 0, Serialized)  // _S0W: S0 Device Wake State
            {
                Return (0x03)
            }

            Method (_S3D, 0, Serialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S3W, 0, Serialized)  // _S3W: S3 Device Wake State
            {
                Return (0x03)
            }

            Method (_S4D, 0, Serialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Method (_S4W, 0, Serialized)  // _S4W: S4 Device Wake State
            {
                Return (0x03)
            }
        }

        Scope (HS03)
        {
            Name (PORT, 0x03)
            PowerResource (BTPR, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (\_SB.GGOV (0x00C407C0))
                }

                Method (_ON, 0, Serialized)  // _ON_: Power On
                {
                    If ((\_SB.GGOV (0x00C407C0) == Zero))
                    {
                        Local0 = 0x00C407C0
                        \_SB.SGOV (Local0, One)
                    }
                }

                Method (_OFF, 0, Serialized)  // _OFF: Power Off
                {
                    If ((\_SB.GGOV (0x00C407C0) == One))
                    {
                        Local0 = 0x00C407C0
                        \_SB.SGOV (Local0, Zero)
                    }
                }
            }

            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                BTPR
            })
            Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
            {
                BTPR
            })
            Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
            {
                BTPR
            })
            Method (_S0W, 0, Serialized)  // _S0W: S0 Device Wake State
            {
                Return (0x02)
            }
        }

        Scope (HS09)
        {
            Device (IBTU)
            {
                Name (_ADR, 0x09)  // _ADR: Address
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                PowerResource (BTPR, 0x00, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((\_SB.GGOV (0x00C40B00) == One))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Method (_ON, 0, Serialized)  // _ON_: Power On
                    {
                        If ((\_SB.GGOV (0x00C40B00) == Zero))
                        {
                            Local0 = 0x00C40B00
                            \_SB.SGOV (Local0, One)
                        }
                    }

                    Method (_OFF, 0, Serialized)  // _OFF: Power Off
                    {
                        If ((\_SB.GGOV (0x00C40B00) == One))
                        {
                            Local0 = 0x00C40B00
                            \_SB.SGOV (Local0, Zero)
                        }
                    }
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    BTPR
                })
                Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
                {
                    BTPR
                })
                Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
                {
                    BTPR
                })
                Method (_S0W, 0, Serialized)  // _S0W: S0 Device Wake State
                {
                    Return (0x02)
                }
            }
        }
    }

    Scope (\_SB)
    {
        PowerResource (SDPR, 0x00, 0x0000)
        {
            Name (_STA, One)  // _STA: Status
            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
            }
        }
    }

    Scope (\_SB.PCI0.SDHA)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            SDPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            SDPR
        })
    }

    Scope (\_SB.PCI0.SDIO)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            SDPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            SDPR
        })
    }

    Scope (\_SB)
    {
        PowerResource (USBC, 0x00, 0x0000)
        {
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (One)
            }

            Method (_ON, 0, NotSerialized)  // _ON_: Power On
            {
            }

            Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
            {
            }
        }
    }

    Scope (\_SB.PCI0.XDCI)
    {
        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
        {
            Return (Zero)
        }

        Method (_PR3, 0, NotSerialized)  // _PR3: Power Resources for D3hot
        {
            Return (Package (0x01)
            {
                USBC
            })
        }

        OperationRegion (PMCS, PCI_Config, 0x74, 0x04)
        Field (PMCS, WordAcc, NoLock, Preserve)
        {
            PMSR,   32
        }

        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            Local0 = PMSR /* \_SB_.PCI0.XDCI.PMSR */
            Local0 &= One
        }
    }

    Scope (\_SB.PCI0)
    {
        PowerResource (PAUD, 0x00, 0x0000)
        {
            Name (PSTA, One)
            Name (ONTM, Zero)
            Name (_STA, One)  // _STA: Status
            Method (_ON, 0, NotSerialized)  // _ON_: Power On
            {
                _STA = One
                PUAM ()
            }

            Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
            {
                _STA = Zero
                PUAM ()
            }

            Method (PUAM, 0, Serialized)
            {
                If ((^_STA == Zero)){}
                Else
                {
                }
            }
        }
    }

    If ((\EMOD == One))
    {
        Scope (\_SB)
        {
            Name (GBPS, Zero)
            PowerResource (MODS, 0x00, 0x0000)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((OSYS >= 0x07DF))
                    {
                        Return (GBPS) /* \_SB_.GBPS */
                    }

                    Return (Zero)
                }

                Method (_ON, 0, NotSerialized)  // _ON_: Power On
                {
                    If ((OSYS >= 0x07DF))
                    {
                        \_SB.PCI0.SATA.PRT0.SPON ()
                        GBPS = One
                    }
                }

                Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                {
                    If ((OSYS >= 0x07DF))
                    {
                        \_SB.PCI0.SATA.PRT0.SPOF ()
                        GBPS = Zero
                    }
                }
            }
        }
    }

    Scope (\_SB.PCI0)
    {
        Method (LPD3, 0, Serialized)
        {
            OperationRegion (PMCS, PCI_Config, 0x84, 0x04)
            Field (PMCS, WordAcc, NoLock, Preserve)
            {
                PMSR,   32
            }

            Local0 = PMSR /* \_SB_.PCI0.LPD3.PMSR */
            Local0 &= One
        }

        PowerResource (LSPR, 0x00, 0x0000)
        {
            Name (_STA, One)  // _STA: Status
            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
            }
        }
    }

    Scope (\_SB.PCI0.PWM)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.I2C0)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.I2C1)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.I2C2)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.I2C3)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.I2C4)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.I2C5)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.I2C6)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.I2C7)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.SPI1)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.SPI2)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.SPI3)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.URT1)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.URT2)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.URT3)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }

    Scope (\_SB.PCI0.URT4)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            LSPR
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            LSPR
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
            LPD3 ()
        }
    }
}

