BEGIN { safe = 0 }

/^.+$/ {
    slope = checkchange($1, $2)
    if (slope == 0) 
        next
    
    for (i = 2; i < NF; i++) {
        change = checkchange($i, $(i + 1))
        if (change == 0 || change != slope)
            next
    }

    safe++
}

END {
    print safe
}

function checkchange(i, j) {
     c = i - j

    if (c == 0) return 0
    if (c > 3) return 0
    if (c < -3) return 0
    return (c > 0) ? 1 : -1
}
