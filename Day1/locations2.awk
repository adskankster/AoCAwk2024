/^.+$/ {
	col1[NR] = $1
    col2[NR] = $2
}

END {
    n2 = asort(col2)

    runningTotal = 0

    for (i in col1) {
        
        foundCount = 0

        for (j = 1; j <= n2; j++) {

            if (col2[j] == col1[i]) {
                foundCount++
            } else if (foundCount > 0) {
                break
            }
            
        }

        runningTotal += (col1[i] * foundCount)
    }

    print runningTotal
}