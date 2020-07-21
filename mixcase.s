        ;.include "common.inc"

Scr_A   = $C1
Scr_Z   = $DA
LCBit   = $20
MON_COut= $FDF0

        .org $300
        CLD
        LDX Flag
        BEQ Upper
Lower:  CMP #Scr_A      ; If the character in Acc is <'A' or >'Z', pass as-is
        BMI COut
        CMP #(Scr_Z+1)
        BCS COut
Flip:   EOR #LCBit      ; Flip lower-case/upper-case
        TAY             ; move char arg out of the way (to Y)
        TXA
        EOR #$01        ; Toggle the upper/lower flag
        STA Flag        ; and save it
        TYA             ; restore char arg
COut:   JMP MON_COut    ; INVOKE the monitor's COut1 function.
Upper:  CMP #(Scr_A|LCBit); If the character in Acc is <'a' or >'z', pass as-is
        BMI COut
        CMP #(Scr_Z|LCBit+1)
        BCS COut
        BCC Flip
        NOP
Flag:   .BYTE $00
