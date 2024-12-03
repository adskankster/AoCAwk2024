BEGIN { 
    FPAT = "(do\\(\\))|(don't\\(\\))|(mul\\([[:digit:]]+,[[:digit:]]+\\))" 
    RS = "\0"
    runingTotal = 0
}

/^.+$/ {
    on = 1

    for (i = 1; i <= NF; i++) {
        ins = substr($i, 1, 3)

        switch (ins) {
            case "mul":
                if (on == 1) {
                    comma = index($i, ",")

                    sub("mul\\(", "", $i)
                    sub(")", "", $i)
                    split($i, values, ",")

                    runningTodal += values[1] * values[2]
                }
                break

            case "don":
                on = 0
                break

            default:
                on = 1
                break
        }
    }
}

END {
    print runningTodal
}