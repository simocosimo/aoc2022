import streams
import strutils

type 
  Morra = enum
    rock = (1, "A"), paper = (2, "B"), scissors = (3, "C")
  Result = enum
    loss = (0, "X"), draw = (1, "Y"), win = (2, "Z")

var
  elf_move: Morra
  expected: Result
  strm = newFileStream("input.txt", fmRead)
  line = ""
  score = 0

proc play_game(e: Morra, r: Result): int =
  var p = Morra.rock 
  if r == Result.draw: p = e
  elif r == Result.win:
    p = if e != Morra.scissors: succ(e) else: Morra.rock
  elif r == Result.loss:
    p = if e != Morra.rock: pred(e) else: Morra.scissors
  return (ord(r) * 3) + ord(p)  # multiplying here because enums with holes are problematic

if not isNil(strm):
  while strm.readLine(line):
    let moves = line.split(' ')
    elf_move = parseEnum[Morra](moves[0])
    expected = parseEnum[Result](moves[1]) 
    score += play_game(
      elf_move,
      expected
    ) 

echo score

