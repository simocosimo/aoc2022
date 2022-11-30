import macros, strutils

macro toEnum(words: static[string]): untyped =
  result = newTree(nnkEnumTy, newEmptyNode())

  for w in splitWhitespace(words):
    result.add ident(w)

type
  Color = toEnum"Red Green Blue Indigo"

var color = Indigo
