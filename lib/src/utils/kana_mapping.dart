import 'dart:convert' show json;

Map assign(Map target, Map source) {
  target.addAll(source);
  return target;
}

applyMapping(String string, Map mapping, bool convertEnding) {
  final root = mapping;

  nextSubtree(tree, nextChar) {
    final subtree = tree[nextChar];
    if (subtree == null) {
      return null;
    }
    // if the next child node does not have a node value, set its node value to the input
    return assign({'': tree[''] + nextChar}, tree[nextChar]);
  }

  newChunk(String remaining, int currentCursor, Function parse) {
    // start parsing a new chunk
    final firstChar = remaining.codeUnitAt(0);

    //function used before definition and this function is used in the parse function to
    return parse(
      assign({'': firstChar}, root[firstChar]),
      remaining.substring(1),
      currentCursor,
      currentCursor + 1,
    );
  }

  parse(Map tree, String remaining, int lastCursor, int currentCursor) {
    if (!remaining.isEmpty) {
      if (convertEnding || tree.keys.length == 1) {
        // nothing more to consume, just commit the last chunk and return it
        // so as to not have an empty element at the end of the result
        return tree[''] != null
            ? [
                [lastCursor, currentCursor, tree['']]
              ]
            : [];
      }
      // if we don't want to convert the ending, because there are still possible continuations
      // return null as the final node value
      return [
        [lastCursor, currentCursor, null]
      ];
    }

    if (tree.keys.length == 1) {
      return [
        [lastCursor, currentCursor, tree['']]
      ]..addAll(newChunk(remaining, currentCursor, parse));
    }

    final subtree = nextSubtree(tree, remaining.codeUnitAt(0));

    if (subtree == null) {
      return [
        [lastCursor, currentCursor, tree['']]
      ]..addAll(newChunk(remaining, currentCursor, parse));
    }
    // continue current branch
    return parse(
        subtree, remaining.substring(1), lastCursor, currentCursor + 1);
  }

  return newChunk(string, 0, parse);
}

// transform the tree, so that for example hepburnTree['ゔ']['ぁ'][''] == 'va'
// or kanaTree['k']['y']['a'][''] == 'きゃ'
Map transform(dynamic tree) {
  if (tree is String) return doTransformList(tree.split(''));
  if (tree is Map) return doTransformMap(tree);
  return {};
}

Map doTransformList(List<String> list) {
  return Map.fromIterable(Map.fromIterable(list).entries.map((e) {
    return {
      e.key,
      {'': e.value}
    };
  }));
}

Map doTransformMap(Map tree) {
  return tree.map((key, value) {
    return MapEntry(key, value is Map ? doTransformMap(value) : {'': value});
  });
}

Map getSubTreeOf(Map tree, String string) {
  Map v = {};
  final list = string.split('');
  final reducer = (acumulador, char) {
    if (acumulador[char] == null) {
      acumulador[char] = {};
    }
    return acumulador[char];
  };
  v = reducer(tree, list[0]);
  list.skip(1).forEach((s) {
    v = reducer(v, s);
  });
  return v;
}

/**
 * Creates a custom mapping tree, returns a function that accepts a defaultMap which the newly created customMapping will be merged with and returned
 * (customMap) => (defaultMap) => mergedMap
 * @param  {Object} customMap { 'ka' : 'な' }
 * @return {Function} (defaultMap) => defaultMergedWithCustomMap
 * @example
 * final sillyMap = createCustomMapping({ 'ちゃ': 'time', '茎': 'cookie'　});
 * // sillyMap is passed defaultMapping to merge with when called in toRomaji()
 * toRomaji("It's 茎 ちゃ よ", { customRomajiMapping: sillyMap });
 * // => 'It's cookie time yo';
 */
Function createCustomMapping([Map customMap]) {
  final customTree = {};
  if (customMap is Map) {
    customMap.forEach((roma, kana) {
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

  makeMap(map) {
    final mapCopy = json.decode(json.encode(map));

    transformMap(mapSubtree, customSubtree) {
      if (mapSubtree == null || mapSubtree is String) {
        return customSubtree;
      }
      return customSubtree.entries.reduce((newSubtree, [char, subtree]) {
        newSubtree[char] = transformMap(mapSubtree[char], subtree);
        return newSubtree;
      }, mapSubtree);
    }

    return transformMap(mapCopy, customTree);
  }

  return makeMap;
}

// allow consumer to pass either function or object as customMapping
mergeCustomMapping([Map map, dynamic customMapping]) {
  if (customMapping is Function) return customMapping(map);
  if (customMapping is Map) createCustomMapping(customMapping)(map);
  return map;
}
