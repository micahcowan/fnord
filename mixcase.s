        ;.include "common.inc"

Scr_A   = $C1
Scr_Z   = $DA
LCBit   = $20
MON_COut= $FDF0

        .org $300
        CLD
        PHA
        LDA Flag
        EOR #$FF
        CMP #$01
        STA Flag
        PLA
        BCC Upper
Lower:  
        CMP #Scr_A      ; If the character in Acc is <'A' or >'Z', pass as-is
        BMI COut
        CMP #(Scr_Z+1)
        BCS COut
Flip:   EOR #LCBit      ; Flip lower-case/upper-case
COut:   JMP MON_COut    ; INVOKE the monitor's COut1 function.
Upper:  CMP #(Scr_A|LCBit); If the character in Acc is <'a' or >'z', pass as-is
        BMI COut
        CMP #(Scr_Z|LCBit+1)
        BCS COut
        BCC Flip
        NOP
Flag:   .BYTE $00
Store_A:.BYTE $00
