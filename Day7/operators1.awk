BEGIN {
    fullTotal = 0
}

/^.+$/ {

    sub(":", "", $1)

    opsCount = NF - 2 
    opsCombo = 2^opsCount

    for (x = 0; x <= opsCombo; x++) {  
        opStr = getOps(x) 

        while ((length(opStr) % opsCount) != 0)
            opStr = "a" opStr

        split(opStr, ops[x], "")
    }

    for (oc = 0; oc < length(ops); oc++) {

        total = $2

        for (o in ops[oc]) {

            if (ops[oc][o] == "m") {
                total *= $(o + 2)
            } else {
                total += $(o + 2)
            }
        }

        if (total == $1) {
            fullTotal += $1
            break
        }
    } 
}

END {
    print "Total = " fullTotal
}

function getOps(noOfOps,    mask, bits, data) {

    if (noOfOps == 0)
        return "a"

    mask = 1
    bits = noOfOps

    for (; bits != 0; bits = rshift(bits, 1))
        data = (and(bits, mask) ? "m" : "a") data

    return data
}
