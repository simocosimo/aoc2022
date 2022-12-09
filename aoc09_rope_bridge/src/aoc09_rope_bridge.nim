import streams, strformat, strutils, system, sequtils

proc inRange(h, t: tuple[x, y: int]): bool =
  result = true
  if abs(h[0] - t[0]) >= 2 or abs(h[1] - t[1]) >= 2:
    result = false

proc stepMove(h, t: var tuple[x, y: int], dir: string) =
  case dir:
    of "R": h[0] += 1
    of "L": h[0] -= 1
    of "U": h[1] += 1
    of "D": h[1] -= 1
    else: quit(1)

  if not inRange(h, t):
    case dir:
      of "R": 
        t[0] = h[0] - 1
        t[1] = h[1]
      of "L":
        t[0] = h[0] + 1
        t[1] = h[1]
      of "U":
        t[0] = h[0]
        t[1] = h[1] - 1
      of "D":
        t[0] = h[0]
        t[1] = h[1] + 1
      else: quit(1)
  # echo(fmt"Moved h to ({h[0]},{h[1]}), t to ({t[0]}, {t[1]})")

var
  strm = newFileStream("input.txt", fmRead)
  line = ""
  Hpos = (0, 0)
  Tpos = (0, 0)
  tpos_list = newSeq[tuple[x, y: int]]()

if not isNil(strm):
  while strm.readLine(line):

    let info = line.split(' ')

    # info[0] = direction
    # info[1] = number of steps
    for i in 0..<parseInt(info[1]):
      stepMove(Hpos, Tpos, info[0])
      tpos_list.add(Tpos)
    # echo tpos_list

echo deduplicate(tpos_list).len()

