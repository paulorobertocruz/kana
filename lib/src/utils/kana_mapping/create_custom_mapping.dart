Map Function(Map) createCustomMapping([Map customMap]) {
  if (customMap == null) customMap = {};
  final customTree = {};

  if (customMap is Map) {
    customMap.entries.forEach((entry) {
      final roma = entry.key;
      final kana = entry.value;
      var subTree = customTree;
      roma.split('').forEach((char) {
        if (subTree[char] == null) {
          subTree[char] = {};
        }
        subTree = subTree[char];
      });
      subTree[''] = kana;
    });
  }

  Map makeMap(Map map) {
    final mapCopy = Map.from(map);

    Map transformMap(Map mapSubtree, Map customSubtree) {
      if (mapSubtree == null || mapSubtree is String) {
        return customSubtree;
      }
      return customSubtree.entries.fold(mapSubtree, (newSubtree, entry) {
        final char = entry.key;
        final subtree = entry.value;
        newSubtree[char] = transformMap(mapSubtree[char], subtree);
        return newSubtree;
      });
    }

    return transformMap(mapCopy, customTree);
  }

  return makeMap;
}
/*
/**
 * Creates a custom mapping tree, returns a function that accepts a defaultMap which the newly created customMapping will be merged with and returned
 * (customMap) => (defaultMap) => mergedMap
 * @param  {Object} customMap { 'ka' : 'な' }
 * @return {Function} (defaultMap) => defaultMergedWithCustomMap
 * @example
 * const sillyMap = createCustomMapping({ 'ちゃ': 'time', '茎': 'cookie'　});
 * // sillyMap is passed defaultMapping to merge with when called in toRomaji()
 * toRomaji("It's 茎 ちゃ よ", { customRomajiMapping: sillyMap });
 * // => 'It's cookie time yo';
 */
export function createCustomMapping(customMap = {}) {
  const customTree = {};

  if (typeOf(customMap) === 'object') {
    Object.entries(customMap).forEach(([roma, kana]) => {
      let subTree = customTree;
      roma.split('').forEach((char) => {
        if (subTree[char] === undefined) {
          subTree[char] = {};
        }
        subTree = subTree[char];
      });
      subTree[''] = kana;
    });
  }

  return function makeMap(map) {
    const mapCopy = JSON.parse(JSON.stringify(map));

    function transformMap(mapSubtree, customSubtree) {
      if (mapSubtree === undefined || typeOf(mapSubtree) === 'string') {
        return customSubtree;
      }
      return Object.entries(customSubtree).reduce((newSubtree, [char, subtree]) => {
        newSubtree[char] = transformMap(mapSubtree[char], subtree);
        return newSubtree;
      }, mapSubtree);
    }

    return transformMap(mapCopy, customTree);
  };
}
*/
