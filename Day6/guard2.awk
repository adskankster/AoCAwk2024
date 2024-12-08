BEGIN { 
    room[0][0] = 0
    FS = ""
}

/^.+$/ {
    for (i = 1; i <= NF; i++) {
        room[NR][i] = $i

        if ($i ~ /(\^|<|>|v)/) {
            startCol = i
            startRow = NR
        }
    }
}

END {
    
    for (r = 1; r <= NR; r++) {
        #print "row = " r
        for (c = 1; c <= NF; c++) {
            delete stepped

            row = startRow
            col = startCol
            guard = room[row][col]

            space = room[r][c]
            if (space == "#" || space ~ /(\^|<|>|v)/) continue
            room[r][c] = "#"

            #print "col = " c

            do {
                stepped[row][col] = guard
                #print "row=" row ", col=" col ", guard=" guard
                guard = checkAhead(col, row, guard)
                if (guard == "") break
                
                step(guard)
                
            } while (stepped[row][col] != guard)

            if (guard != "") room[0][0]++

            room[r][c] = space 
        }
    }

    print room[0][0] # 1505 too low
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