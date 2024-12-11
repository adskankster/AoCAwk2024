BEGIN {}

/.+/ {
    for (i = 1; i <= NF; i++) {
        stones[i] = $i
    }
}

END {

    for (b = 1; b <= 25; b++) {
        nos = length(stones)
        new = 1

        for (i = 1; i <= nos; i++) {
            if (stones[i] == 0) {
                stones[i] = 1

            } else if (length(stones[i]) % 2 == 0) {
                half = length(stones[i]) / 2

                rear = substr(stones[i], half + 1)
                stones[nos + new++] = rear * 1

                front = substr(stones[i], 1, half)
                stones[i] = front * 1
            } else {
                stones[i] = stones[i] * 2024
            }
        }
    }
    
    print length(stones)
}