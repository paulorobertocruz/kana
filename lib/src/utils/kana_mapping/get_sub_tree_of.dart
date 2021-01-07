Map getSubTreeOf(Map tree, String string) {
  return string.split('').fold(tree, (Map map, String char) {
    if (!map.containsKey(char)) {
      map[char] = {};
    }
    return map[char];
  });
}

/*
export function getSubTreeOf(tree, string) {
  return string.split('').reduce((correctSubTree, char) => {
    if (correctSubTree[char] === undefined) {
      correctSubTree[char] = {};
    }
    return correctSubTree[char];
  }, tree);
}
*/
