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

    var range1: seq[int] = @[]
    var range2: seq[int] = @[]
    for i in info[0][0]..info[0][1]: range1.add(i)
    for i in info[1][0]..info[1][1]: range2.add(i)

    for i in range1:
      if i in range2: 
        inc(count)
        break

echo count

