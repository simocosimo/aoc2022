import streams
import strutils

type 
  Morra = enum
    rock = 1, paper = 2, scissors = 3
  Result = enum
    loss = 0, draw = 3, win = 6

var
  elf_move: Morra
  my_move: Morra
  strm = newFileStream("input.txt", fmRead)
  line = ""
  score = 0

proc map_moves(m: string): Morra =
  case(m):
    of "A", "X": result = Morra.rock
    of "B", "Y": result = Morra.paper
    of "C", "Z": result = Morra.scissors
  return

proc play_game(e, p: Morra): int  =
  var res = Result.loss
  if (ord(p) == ord(e) + 1) or (p == Morra.rock and e == Morra.scissors):
    res = Result.win
  if p == e: res = Result.draw
  return ord(res) + ord(p)

if not isNil(strm):
  while strm.readLine(line):
    let moves = line.split(' ')
    elf_move = map_moves(moves[0])
    my_move = map_moves(moves[1])
    score += play_game(
      elf_move,
      my_move
    ) 

echo score

