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

    while (blockPointer > 1) {

        while (disk[blockPointer] == " ") {
            blockPointer--
        }
        blockLength = 0
        fileId = disk[blockPointer]
        if (fileId == 0) break

        while (disk[blockPointer] == fileId) {
            blockPointer--
            blockLength++
        }

        spaceIndex = checkNextSpace(blockLength)
        if (spaceIndex >= blockPointer) continue
        if (spaceIndex > 0) {
            for (m = 1; m <= blockLength; m++) {
                disk[spaceIndex + m - 1] = disk[blockPointer + m]
            }

            for (d = 1; d <= blockLength; d++) {
                disk[blockPointer + d] = " "
            }
        } 
    }

    checksum = 0
    for (i in disk) {
        checksum += disk[i] * (i - 1)
    }

    print checksum
}

function findNextSpace(curPointer) {
    while (++curPointer in disk) {
        if (disk[curPointer] == " ") return curPointer
    }

    return curPointer++
}

function checkNextSpace(wantedLength,     curFreePointer) {
    curFreePointer = findNextSpace(1)
    do {
        cfp = 0
        while (disk[curFreePointer + cfp] == " ") {
            cfp++
            if (!((curFreePointer + cfp) in disk)) {
                return 0
            }
        }

        if (cfp >= wantedLength) {
            return curFreePointer
        } else {
            curFreePointer = findNextSpace(curFreePointer + cfp)
            cfp = 0
        }
    } while ((curFreePointer + cfp) in disk)
    
    return 0
}

function getDiskLength() {
    max = 0
    for (x in disk) {
        max++
    }
    return max
}