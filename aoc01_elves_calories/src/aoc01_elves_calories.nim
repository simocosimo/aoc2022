import streams
import strutils
import strformat

var strm = newFileStream("input.txt", fmRead)
var line = ""

var 
  count = 0
  max = 0 
  index = 0

if not isNil(strm):
  while strm.readLine(line):
    inc index
    if line == "":
      if count > max: 
        max = count
      count = 0
      continue
    
    count = count + parseInt(line)

echo max
