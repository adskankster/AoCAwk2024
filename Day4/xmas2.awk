BEGIN { 
    FS = ""
    grid[0][0] = 0
}

/^.+$/ {
    for (i = 1; i <= NF; i++) {
        grid[NR][i] = $i
    }
}

END {
    for (y = 1; y <= NR; y++) {
        for (x = 1; x <= NF; x++) {
            if (grid[y][x] == "A") {
                checkCell(x, y)
            }
        }
    }

    print grid[0][0]
}

function checkCell(x, y) {
    a = checkMas(x-1, y-1, x+1, y+1)
    b = checkMas(x+1, y+1, x-1, y-1)
    c = checkMas(x-1, y+1, x+1, y-1)
    d = checkMas(x+1, y-1, x-1, y+1)

    if (a + b + c + d == 2) grid[0][0]++
}

function checkMas(x1, y1, x2, y2) {
    if (grid[y1][x1] == "M" &&
        grid[y2][x2] == "S") return 1

    return 0
}
