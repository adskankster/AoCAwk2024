BEGIN {
    FS = ""
    map[0][0] = 0
    top[0][0] = 0
}

/^.+$/ {
    for (i = 1; i <= NF; i++) {
        map[i][NR] = $i
        if ($i == 9) top[i][NR] = 0
    }
}

END {
    for (x = 1; x <= NF; x++) {
        for (y = 1; y <= NR; y++) {
            if (map[x][y] == 0) {
                checkPoint(x, y)
                clearTops()
                th++
            }
        }
    }

    for (t in map[0]) {
        print map[0][t]
    }
    print map[0][0]
}

function clearTops() {
    for (a in top) {
        for (b in top[a]) {
            top[a][b] = 0
        }
    }
}

function checkPoint(x, y,    z) {

    z = map[x][y]

    print x "," y "= " z
    if (z == 9 && top[x][y] == 0) {
        map[0][0]++
        top[x][y] = 1
        return
    }

    if (checkNorth(x, y, z) == 1) {
        checkPoint(x, y - 1)
    }
    if (checkEast(x, y, z) == 1) {
        checkPoint(x + 1, y)
    }
    if (checkSouth(x, y, z) == 1) {
        checkPoint(x, y + 1)
    }
    if (checkWest(x, y, z) == 1) {
        checkPoint(x - 1, y)
    }
}

function checkNorth(x, y, z) {
    if (y > 1) {
        return checkSquare(x, y - 1, z)
    }

    return 0
}

function checkEast(x, y, z) {
    if (x < NF) {
        return checkSquare(x + 1, y, z)
    }

    return 0
}

function checkSouth(x, y, z) {
    if (y < NR) {
        return checkSquare(x, y + 1, z)
    }

    return 0
}

function checkWest(x, y, z) {
    if (x > 1) {
        return checkSquare(x - 1, y, z)
    }

    return 0
}

function checkSquare(x, y, z) {
    if (map[x][y] == z + 1) {
        return 1
    }
    return 0
}