BEGIN {
    FS = "|"
    order[0][0]
    pages[0][0]

    correct = 0
}

/^.+\|.+$/ {
    order[$1][$2] = 1
}

/^$/ {
    FS = ","
}

/.+,.+$/ {
    for (i = NF; i > 1; i--) {
        for (j = i - 1; j > 0; j--) {
            if ($j in order[$i]) next
        }
    }

    middle = int(NF / 2) + 1
    correct += $middle
}

END {
    print correct
}