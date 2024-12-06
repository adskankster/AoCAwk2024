BEGIN { 
    room[0][0] = 0
    stepped[0][0] = 0
    FS = ""
}

/^.+$/ {
    for (i = 1; i <= NF; i++) {
        room[NR][i] = $i

        if ($i ~ /(\^|<|>|v)/) {
            col = i
            row = NR
        }
    }
}

END {
    guard = room[row][col]

    while (guard != "") {
        stepped[row][col] = 1
        guard = checkAhead(col, row, guard)
        if (guard != "") step(guard)
    }

    for (y = 1; y <= NR; y++) {
        for (x = 1; x <= NF; x++) {
            if (stepped[y][x] == 1) {
                stepped[0][0]++
            }
        }
    }

    print stepped[0][0]
}

function rotateRight(direction) {
    switch (direction) {
        case "^": return ">"
            break
        case ">": return "v"
            break
        case "v": return "<"
            break
        default: return "^"
            break
    }
}

function step(direction) {
    switch (direction) {
        case "^": row--
            break
        case ">": col++
            break
        case "v": row++
            break
        default: col--
            break
    }
}

function checkAhead(x, y, facing,    contents, nextx, nexty) {
    switch (facing) {
        case "^": 
            nextx = x
            nexty = y - 1
            break
        case ">": 
            nextx = x + 1
            nexty = y
            break
        case "v": 
            nextx = x
            nexty = y + 1
            break
        default: 
            nextx = x - 1
            nexty = y
            break
    }

    if (nextx > 0 && nextx <= NF && nexty > 0 && nexty <= NR) {
        contents = room[nexty][nextx]
    } else {
        return ""
    }
    
    if (contents == "#") {
        return rotateRight(facing)
    } else {
        return facing
    }
}