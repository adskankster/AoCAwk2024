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
    delete p
    split($0, p, ",")
    #printp()

    for (i = NF; i > 1; i--) {
        for (j = i - 1; j > 0; j--) {
            #print "i= " i ", p[i]=" p[i] ", j=" j ", p[j]=" p[j]
            if (p[j] in order[p[i]]) {
                asort(p, p, "reorder")
                middle = int(NF / 2) + 1
                corrected += p[middle]
                next
            }
        }
    }    
}

END {
    print corrected
}

function reorder(i1, v1, i2, v2) {
    if (v1 in order[v2]) {
        return -1
    } else if (v2 in order[v1]) {
        return 1
    }

    return 0
}

function printp() {
    for (x in p) {
        printf "%s, ", p[x] 
    }
    print ""
}