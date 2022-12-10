import streams, strformat, strutils, system, sequtils

proc inRange(h, t: tuple[x, y: int]): bool =
  result = true
  if abs(h[0] - t[0]) >= 2 or abs(h[1] - t[1]) >= 2:
    result = false
    

proc isDiagonal(h, t: tuple[x, y: int]): bool =
  result = false
  if abs(h[0] - t[0]) >= 1 and abs(h[1] - t[1]) >= 1:
    result = true

proc stepMove(h, t: var tuple[x, y: int], dir: string, isHead: bool) =
  if isHead:
   case dir:
     of "R": h[0] += 1
     of "L": h[0] -= 1
     of "U": h[1] += 1
     of "D": h[1] -= 1
     else: quit(1)

  if not inRange(h, t) or not isHead:
    case dir:
      of "R":
        if isDiagonal(h, t) and not isHead:
          let dx = h[0] - t[0]
          let dy = h[1] - t[1]
          t = (t[0] + dx + (if dx < 0: 1 else: -1), t[1] + dy)
        else:
          t[0] = h[0] - 1
          t[1] = h[1]
      of "L":
        if isDiagonal(h, t) and not isHead:
          let dx = h[0] - t[0]
          let dy = h[1] - t[1]
          t = (t[0] + dx + (if dx < 0: 1 else: -1), t[1] + dy)
        else:
          t[0] = h[0] + 1
          t[1] = h[1]
      of "U":
        if isDiagonal(h, t) and not isHead:
          let dx = h[0] - t[0]
          let dy = h[1] - t[1]
          t = (t[0] + dx + (if dx < 0: 1 else: -1), t[1] + dy)
        else:
          t[0] = h[0]
          t[1] = h[1] - 1
      of "D":
        if isDiagonal(h, t) and not isHead:
          let dx = h[0] - t[0]
          let dy = h[1] - t[1]
          t = (t[0] + dx + (if dx < 0: 1 else: -1), t[1] + dy)
        else:
          t[0] = h[0]
          t[1] = h[1] + 1
      else: quit(1)
  # else: echo "In range, so no move"
  # echo(fmt"Moved h to ({h[0]},{h[1]}), t to ({t[0]}, {t[1]})")

var
  strm = newFileStream("test_input.txt", fmRead)
  line = ""
  # Hpos = (0, 0)
  # Tpos = (0, 0)
  snake: array[10, tuple[x, y: int]]
  tpos_list = newSeq[tuple[x, y: int]]()

for i in 0..<10:
  snake[i] = (0, 0)

if not isNil(strm):
  while strm.readLine(line):

    let info = line.split(' ')

    # info[0] = direction
    # info[1] = number of steps
    for i in 0..<parseInt(info[1]):
      for k in 1..<snake.len():
        stepMove(snake[k-1], snake[k], info[0], k == 1)
      echo(fmt"New snake position: {snake}")
      tpos_list.add(snake[^1])
    # echo tpos_list

# echo tpos_list
echo deduplicate(tpos_list).len()

