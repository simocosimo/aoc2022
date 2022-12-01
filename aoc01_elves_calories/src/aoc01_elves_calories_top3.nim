import streams
import strutils
import strformat
import algorithm
import sequtils

var strm = newFileStream("input.txt", fmRead)
var line = ""

var 
  count = 0
  index = 0
  acc = newSeq[int]()

if not isNil(strm):
  while strm.readLine(line):
    inc index
    if line == "":
      acc.add(count)
      count = 0
      continue
    
    count = count + parseInt(line)

acc.sort(SortOrder.Descending)
echo(fmt"{acc[0..2].foldl(a + b)}")
