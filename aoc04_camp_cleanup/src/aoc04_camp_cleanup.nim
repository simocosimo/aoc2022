import streams
import strutils

var strm = newFileStream("input.txt", fmRead)
var line = ""
var count = 0
type bounds = array[0..1, int]
var info: array[0..1, bounds]

if not isNil(strm):
  while strm.readLine(line):
    var pairs = line.split(',')
    for p in 0..<pairs.len():
      let splitted = pairs[p].split('-')
      info[p] = [parseInt(splitted[0]), parseInt(splitted[1])]

    let min = min(info[0][0], info[1][0])
    let max = max(info[0][1], info[1][1])
    
    if (info[0][0] == min and info[0][1] == max) or (info[1][0] == min and info[1][1] == max):
        inc(count)

echo count

