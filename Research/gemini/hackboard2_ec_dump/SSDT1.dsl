/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT1
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000B1 (177)
 *     Revision         0x01
 *     Checksum         0x05
 *     OEM ID           "Intel_"
 *     OEM Table ID     "ADebTabl"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160930 (538315056)
 */
DefinitionBlock ("", "SSDT", 1, "Intel_", "ADebTabl", 0x00001000)
{
    Scope (\)
    {
        Name (DPTR, 0x79C49000)
        Name (EPTR, 0x79C59000)
        Name (CPTR, 0x79C49010)
        Mutex (MMUT, 0x00)
        Method (MDBG, 1, Serialized)
        {
            Local0 = Acquire (MMUT, 0x03E8)
            If ((Local0 == Zero))
            {
                OperationRegion (ABLK, SystemMemory, CPTR, 0x10)
                Field (ABLK, ByteAcc, NoLock, Preserve)
                {
                    AAAA,   128
                }

                AAAA = Arg0
                CPTR += 0x10
                If ((CPTR >= EPTR))
                {
                    CPTR = (DPTR + 0x10)
                }

                Release (MMUT)
            }

            Return (Local0)
        }
    }
}

