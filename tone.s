.macpack apple2

WAIT   = $FCA8
SPKR   = $C030
Scr_SPC = $a0

.include "install.inc"

; Easy-to-edit locations of the timings
;  and temp var "holes"
TONE_LENGTH:
        .BYT $05
TONE_INTER_NS:
        .BYT $30
TONE_INTER_SP:
        .BYT $2E
TONE_INTER:
        NOP
CHARSV:
        NOP

        NOP
        
Begin:  CLD
        JSR MON_COut
        STA CHARSV
        CMP #Scr_SPC
        BEQ Space
        LDA TONE_INTER_NS
        BNE SetTone
Space:  LDA TONE_INTER_SP
SetTone:STA TONE_INTER
        ; Push X, Y
        TXA
        PHA
        TYA
        PHA
        ; Play the tone
        LDY TONE_LENGTH
Tone:   LDA TONE_INTER
        JSR WAIT
        LDA SPKR
        DEY
        BNE Tone
        ; Pause for (nearly) same length of time as tone
        LDY TONE_LENGTH
Tone1:  LDA TONE_INTER
        JSR WAIT
        DEY
        BNE Tone1
        ; Restore regs
        PLA
        TAY
        PLA
        TAX
        LDA CHARSV

        RTS
        NOP
