import streams, strutils, algorithm

type
  Row = seq[int]
  Matrix = seq[Row]

proc transpose(m: Matrix, size: int): Matrix =
  result = newSeq[Row](size)
  for y in 0..<size:
    result[y].add(newSeq[int](size))
    for x in 0..<size:
      result[y][x] = m[x][y]

proc findFirstBigger(s: seq[int], t: int): int =
  result = s.len()
  for i, v in s:
    if v >= t:  return i + 1

var
  strm = newFileStream("input.txt", fmRead)
  line = ""
  m: Matrix = newSeq[Row]()
  m_t: Matrix
  best_score = 0

if not isNil(strm):
  while strm.readLine(line):
    # just populate the matrix and the transpose
    m.add(newSeq[int]())
    for i in line:
      m[^1].add(parseInt($i))

m_t = transpose(m, m[0].len())

for y in 1..<m.len() - 1:
  for x in 1..<m[0].len() - 1:

    let left_view = reversed(m[y][0..<x]).findFirstBigger(m[y][x])
    let right_view = m[y][x+1..^1].findFirstBigger(m[y][x])
    let up_view = reversed(m_t[x][0..<y]).findFirstBigger(m_t[x][y])
    let bottom_view = m_t[x][y+1..^1].findFirstBigger(m_t[x][y])

    var local_score = left_view * right_view * up_view * bottom_view
    if local_score > best_score: best_score = local_score

echo best_score
