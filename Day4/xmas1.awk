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
            if (grid[y][x] == "X") {
                checkCell(x, y)
            }
        }
    }

    print grid[0][0]
}

function checkCell(x, y) {
    checkXmas(x, x, x, y-1, y-2, y-3)
    checkXmas(x+1, x+2, x+3, y-1, y-2, y-3)
    checkXmas(x+1, x+2, x+3, y, y, y)
    checkXmas(x+1, x+2, x+3, y+1, y+2, y+3)
    checkXmas(x, x, x, y+1, y+2, y+3)
    checkXmas(x-1, x-2, x-3, y+1, y+2, y+3)
    checkXmas(x-1, x-2, x-3, y, y, y)
    checkXmas(x-1, x-2, x-3, y-1, y-2, y-3)
}

function checkXmas(x1, x2, x3, y1, y2, y3) {
    if (grid[y1][x1] == "M" &&
        grid[y2][x2] == "A" &&
        grid[y3][x3] == "S") grid[0][0]++
}
