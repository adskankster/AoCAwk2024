BEGIN { 
    FS = ""
}

{
    fileId = -1
    pointer = 1
    for (i = 1; i <= NF; i++) {
        
        if (i % 2 == 1) {
            v = ++fileId
        } else {
            v = " "
        }

        for (b = 1; b <= $i; b++) {
            disk[pointer++] = v
        }
    }
}

END {
    diskLength = getDiskLength()
    blockPointer = diskLength
    freePointer = findNextSpace(1)

    while (blockPointer > freePointer) {
        if (disk[blockPointer] != " ") {
            disk[freePointer++] = disk[blockPointer]
            delete disk[blockPointer]
        }

        blockPointer--

        if (disk[freePointer] != " ") {
            freePointer = findNextSpace(freePointer)
        }
    }

    checksum = 0
    for (i in disk) {
        #printf "%s", disk[i]
        checksum += disk[i] * (i - 1)
    }

    print checksum
}

function findNextSpace(curPointer) {
    while (disk[curPointer] != " ") {
        curPointer++
    }

    return curPointer
}

function getDiskLength() {
    max = 0
    for (x in disk) {
        max++
    }
    return max
}