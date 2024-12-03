BEGIN { 
    FPAT = "mul\\([[:digit:]]+,[[:digit:]]+\\)" 
    RS = "\0"
    runingTotal = 0
}


/^.+$/ {
    for (i = 1; i <= NF; i++) {

        comma = index($i, ",")

        sub("mul\\(", "", $i)
        sub(")", "", $i)
        split($i, values, ",")

        runningTodal += values[1] * values[2]
    }
}

END {
    print runningTodal
}