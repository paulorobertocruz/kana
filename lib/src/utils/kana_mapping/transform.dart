Map transform(Map<String, dynamic> tree) {
  return tree.entries.fold({}, (Map map, MapEntry element) {
    final String char = element.key;
    final subtree = element.value;
    final endOfBranch = subtree is String;
    map[char] = endOfBranch ? {'': subtree} : transform(subtree);
    return map;
  });
}
/*
// transform the tree, so that for example hepburnTree['ゔ']['ぁ'][''] === 'va'
// or kanaTree['k']['y']['a'][''] === 'きゃ'
export function transform(tree) {
  return Object.entries(tree).reduce((map, [char, subtree]) => {
    const endOfBranch = typeOf(subtree) === 'string';
    map[char] = endOfBranch ? { '': subtree } : transform(subtree);
    return map;
  }, {});
}
*/
