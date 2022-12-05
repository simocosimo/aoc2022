import streams
import strutils

const cols = 9 
var strm = newFileStream("input.txt", fmRead)
var line = ""
var 
  inputMode = 0
  stacks: seq[seq[char]] = newSeq[seq[char]](cols)

if not isNil(strm):
  while strm.readLine(line):
    if line.isEmptyOrWhitespace(): continue
    if inputMode == 0:  # reading stacks
      if line[0..1] == " 1":
        inputMode = 1
        continue

      var i: int = 0
      for c in countup(1, line.len() - 1, 4):
        if line[c] != ' ': stacks[i].add(line[c])
        i += 1
        i = i mod cols
    else:   # executing moves
      var 
        count = parseInt(line[5..<line.len()].split(" from ")[0])
        f = parseInt(line[5..<line.len()].split(" from ")[1].split(" to ")[0]) - 1
        to = parseInt(line[5..<line.len()].split(" from ")[1].split(" to ")[1]) - 1

      for x in 0..<count:
        stacks[to].insert(stacks[f][0], x)
        stacks[f].delete(0)

for i in 0..<cols:
  stdout.write(stacks[i][0])
stdout.write('\n')
