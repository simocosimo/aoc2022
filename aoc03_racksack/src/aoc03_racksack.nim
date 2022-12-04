import streams
import strutils

var strm = newFileStream("input.txt", fmRead )
var line = ""
var count = 0

if not isNil(strm):
  while strm.readLine(line):
   
    let middlePoint = (line.len() / 2).toInt()
    let firstHalf = line[0..<middlePoint]
    let secondHalf = line[middlePoint..<line.len()]

    for c in firstHalf:
      if c in secondHalf:
        if not isUpperAscii(c): count += (ord(c) - 96) 
        else: count += (ord(c) - 38)
        break

  echo count

