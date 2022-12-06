import streams
import deques
import sequtils

const queueSize = 14 
var
  strm = newFileStream("input.txt", fmRead)
  line = ""
  queue = initDeque[char](0) 

proc checkQueue(q: Deque): bool =
  let unique = deduplicate(toOpenArray(toSeq(q.items), 0, q.len() - 1))
  result = unique.len() == q.len()

if not isNil(strm):
  line = strm.readLine()
  for i in 0..<queueSize:
    queue.addLast(line[i])

  if not checkQueue(queue):
    # now I have the starting queue set up
    for i in queueSize..<line.len():
      queue.popFirst()
      queue.addLast(line[i])
      if checkQueue(queue):
        echo i + 1 
        echo queue
        break
  else:
    echo queueSize 
