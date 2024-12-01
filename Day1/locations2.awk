/^.+$/ {
	col1[NR] = $1
    col2[NR] = $2
}

END {
    n2 = asort(col2)

    runningTotal = 0

    for (i in col1) {
        left = col1[i]
        
        found = 0
        foundCount = 0

        for (j = 1; j <= n2; j++) {

            if (col2[j] == left) {
                found = 1
                foundCount++
            } else {
                if (found == 1)
                    break
            }
        }

        runningTotal += (left * foundCount)
    }

    print runningTotal
}