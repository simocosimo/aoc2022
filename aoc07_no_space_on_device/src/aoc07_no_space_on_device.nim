import streams, strutils, strformat

# Node data type to build the tree
type 
  Node = ref object
    size: int
    name: string
    children: seq[Node]
    parent: Node

proc viewTree(root: Node, deep: int) = 
  echo(fmt"{repeat('\t', deep)}- Node '{root.name}' size={root.size}")
  for n in root.children:
    viewTree(n, deep + 1)

proc sumOfDirs(root: Node, limit: int): int = 
  var tot = if root.size > limit: 0 else: root.size
  for c in root.children:
    tot += sumOfDirs(c, limit)
  return tot

const size_limit = 100000

var
  strm = newFileStream("input.txt", fmRead)
  line = ""
  root = Node(size: 0, name: "/", children: newSeq[Node](), parent: nil) 
  now_node = root

if not isNil(strm):
  while strm.readLine(line):
    #check if I'm parsing a command
    if line[0] == '$':
      if line[2..3] == "cd": 
        if line[5..^1] == "..": 
          now_node = now_node.parent
          continue

        now_node = 
          block:
            var result: Node = nil
            for i in now_node.children:
              if i.name == line[5..^1]: 
                result =  i
            result

      if isNil(now_node): now_node = root
      continue

    #here I'm parsing the ls output
    if line[0..2] == "dir":
      now_node.children.add(
        Node(size: 0, name: line[4..^1], children: newSeq[Node](), parent: now_node)
      )
    else:
      #here I'm parsing a file
      let info = line.split(" ")
      var local_node = now_node
      while not isNil(local_node):
        local_node.size += parseInt(info[0])
        local_node = local_node.parent

# viewTree(root, 0)
echo(fmt"Sum of dirs with max size {size_limit}: {sumOfDirs(root, size_limit)}")
