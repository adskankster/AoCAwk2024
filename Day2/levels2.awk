BEGIN { safe = 0 }

/^.+$/ {

    split($0, fullArr)
    
    res = checkArr(fullArr)
    if (res == 0 || checkUnsafe(res) == 0) {
        ++safe
    }

    next
}

END {
    print safe " / " NR
}

function checkchange(i, j) {
     c = j - i

    if (c == 0) return 0
    if (c > 3) return 0
    if (c < -3) return 0
    return (c > 0) ? 1 : -1
}

function checkUnsafe(k) {
    if (checkSkip(k - 1) == 0 || 
        checkSkip(k) == 0 || 
        checkSkip(k + 1) == 0) return 0

    return 1
}

function checkSkip(ti) {
    if (ti < 1) return 1

    delete t
    ai = 1
    for (j = 1; j <= NF; j++) {
        if (j != ti) {
            t[ai++] = $j
        }
    }

    return checkArr(t)
}

function checkArr(array) {
    slope = checkchange(array[1], array[2])
    if (slope == 0) return 1

    for (di = 2; di < NF; di++) {
        
        if ((di + 1) in array) {
            change = checkchange(array[di], array[di + 1])
            if (change == 0 || change != slope) {
                return di
            }
        }
    }

    return 0
}