import streams
import strutils

var strm = newFileStream("input.txt", fmRead )
var line = ""
var count = 0
var elfGroup: array[0..2, string]
var elfCount = 0

if not isNil(strm):
  while strm.readLine(line):
   
    elfGroup[elfCount] = line
    elfCount += 1
    if elfCount > 2:
      for c in elfGroup[0]:
        if c in elfGroup[1] and c in elfGroup[2]:
          if not isUpperAscii(c): count += (ord(c) - 96) 
          else: count += (ord(c) - 38)
          break
      elfCount = 0

  echo count

