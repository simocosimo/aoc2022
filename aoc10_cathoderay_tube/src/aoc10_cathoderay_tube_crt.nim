import streams, strutils, tables

var
  strm = newFileStream("input.txt", fmRead)
  line = ""
  cycle = 1
  isa = {
    "noop": 1,
    "addx": 2
  }.toTable
  X = 1
  crt_cycle = 40
  crt_output = ""

if not isNil(strm):
  while strm.readLine(line):

    let info = line.split(' ')
    for i in 0..<isa[info[0]]:
      let newPixel = 
        block:  
          let pos = (cycle - 1) mod crt_cycle
          var res = ""
          if pos == 0: res = "\n"
          if pos in X-1..X+1: res & "#"
          else: res & "."
      crt_output &= newPixel
      cycle += 1
    case info[0]:
      of "addx": X += parseInt(info[1])
      else: X += 0

echo crt_output
