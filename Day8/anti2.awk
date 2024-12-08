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

            an0 = i "," NR
            if (!(an0 in antinodes)) {
                antinodes[an0] = 1
            }
        }
    }

}

END {
    for (a in antennae) {
        if (a == "#") continue

        for (b = 1; b < antennae[a][0]; b++) {

            x1 = antennae[a][b]["x"]
            y1 = antennae[a][b]["y"]

            for (i = b + 1; i <= antennae[a][0]; i++) {
                x2 = antennae[a][i]["x"]
                y2 = antennae[a][i]["y"]

                dx = x2 - x1
                dy = y2 - y1

                an1x = x1 - dx
                an1y = y1 - dy

                while ((an1x >= 1) && (an1x <= NF) && (an1y >= 1) && (an1y <= NR)) {
                    an1 = an1x "," an1y
                    if (!(an1 in antinodes)) {
                        antinodes[an1] = 1
                    }

                    an1x = an1x - dx
                    an1y = an1y - dy
                }

                an2x = x2 + dx
                an2y = y2 + dy

                while ((an2x >= 1) && (an2x <= NF) && (an2y >= 1) && (an2y <= NR)) {
                    an2 = an2x "," an2y
                    if (!(an2 in antinodes)) {
                        antinodes[an2] = 1
                    }

                    an2x = an2x + dx
                    an2y = an2y + dy
                }
            }
        }
    }

    max = -1
    for (count in antinodes) {
        max++
    }
    print max
}