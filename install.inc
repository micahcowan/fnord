DosCswl = $AA53

        ;; This is how you hook an output routine in DOS 3.3
        ;; - though the routine is the same, how to hook it is different
        ;;   in ProDOS, and different again with no DOS loaded
        LDA #<Begin
        STA DosCswl
        LDA #>Begin
        STA DosCswl+1
        RTS
