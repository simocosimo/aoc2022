import streams, strutils 

type
  Row = seq[int]
  Matrix = seq[Row]

proc transpose(m: Matrix, size: int): Matrix =
  result = newSeq[Row](size)
  for y in 0..<size:
    result[y].add(newSeq[int](size))
    for x in 0..<size:
      result[y][x] = m[x][y]

var
  strm = newFileStream("input.txt", fmRead)
  line = ""
  m: Matrix = newSeq[Row]()
  m_t: Matrix
  count = 0

if not isNil(strm):
  while strm.readLine(line):
    # just populate the matrix and the transpose
    m.add(newSeq[int]())
    for i in line: m[^1].add(parseInt($i))

m_t = transpose(m, m[0].len())

for y in 1..<m.len() - 1:
  for x in 1..<m[0].len() - 1:

    if m[y][x] == 0: continue

    # check for left/right visibility
    if max(m[y][0..<x]) < m[y][x] or max(m[y][x+1..^1]) < m[y][x]:
      count += 1
      continue

    # check for up/down visibility
    if max(m_t[x][0..<y]) < m_t[x][y] or max(m_t[x][y+1..^1]) < m_t[x][y]: 
      count += 1
      continue

count += (m[0].len() * 2) + ((m[0].len() - 2) * 2)
echo count
