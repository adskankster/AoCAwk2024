BEGIN { 
    FS = ""
    antinodes[0] = 0
    antennae["#"][0]["x"] = 0
    antennae["#"][0]["y"] = 0

}

/^.*[[:alnum:]]+.*$/ {

    for (i = 1; i <= NF; i++) {
        if ($i != ".") {
            if (!($i in antennae)) {
                antennae[$i][0] = 0
            }

            antennae[$i][0]++
            antennae[$i][antennae[$i][0]]["x"] = i
            antennae[$i][antennae[$i][0]]["y"] = NR
        }
    }

}

END {
    for (a in antennae) {
        if (a == "#") continue

        for (b = 1; b < antennae[a][0]; b++) {

            x1 = antennae[a][b]["x"]
            y1 = antennae[a][b]["y"]
            #print a "-a1 = " x1 ", " y1

            for (i = b + 1; i <= antennae[a][0]; i++) {
                x2 = antennae[a][i]["x"]
                y2 = antennae[a][i]["y"]
                #print a "-a2 = " x2 ", " y2


                dx = (x2 - x1)
                dy = (y2 - y1)

                an1x = x1 - dx
                an1y = y1 - dy

                if ((an1x >= 1) && (an1x <= NF) && (an1y >= 1) && (an1y <= NR)) {
                    an1 = an1x "," an1y
                    if (!(an1 in antinodes)) {
                        #print an1
                        antinodes[an1] = 1
                    }
                }

                an2x = x2 + dx
                an2y = y2 + dy

                if ((an2x >= 1) && (an2x <= NF) && (an2y >= 1) && (an2y <= NR)) {
                    an2 = an2x "," an2y
                    if (!(an2 in antinodes)) {
                        #print an2
                        antinodes[an2] = 1
                    }
                }
            }
        }
    }

    max = -1
    for (count in antinodes) {
        #print count
        max++
    }
    print max
}