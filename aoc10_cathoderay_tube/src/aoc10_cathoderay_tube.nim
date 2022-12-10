import streams, strutils, strformat, tables

var
  strm = newFileStream("input.txt", fmRead)
  line = ""
  cycle = 1
  isa = {
    "noop": 1,
    "addx": 2
  }.toTable
  X = 1
  res = 0
  threshold = 20

if not isNil(strm):
  while strm.readLine(line):

    let info = line.split(' ')
    for i in 0..<isa[info[0]]:
      if cycle == threshold:
        res += (X * cycle)
        threshold += 40
      cycle += 1
    case info[0]:
      of "addx": X += parseInt(info[1])
      else: X += 0

echo res
