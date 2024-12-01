
/^.+$/ {
	col1[NR] = $1
    col2[NR] = $2
}

END {
    n1 = asort(col1)
    n2 = asort(col2)

    runningTotal = 0

    for (i = 1; i <= n1; i++) {
        runningTotal += abs(col1[i] - col2[i])
    }

    print runningTotal
}

function abs(number) {
    if (number < 0)
        number *= -1
    
    return number
}