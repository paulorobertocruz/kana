import 'package:kana/src/utils/is_empty.dart';

applyMapping(String string, Map mapping, bool convertEnding) {
  final Map root = mapping;

  nextSubtree(Map<String, dynamic> tree, String nextChar) {
    final subtree = tree[nextChar];
    if (subtree == null) {
      return null;
    }
    // if the next child node does not have a node value, set its node value to the input
    return tree[nextChar].addAll({'': tree[''] + nextChar});
  }

  List newChunk(String remaining, currentCursor, Function parse) {
    // start parsing a new chunk
    final firstChar = remaining[0];

    return parse(root[firstChar].addAll({'': firstChar}),
        remaining.substring(1), currentCursor, currentCursor + 1);
  }

  List parse(Map tree, String remaining, lastCursor, currentCursor) {
    if (isEmpty(remaining)) {
      if (convertEnding || tree.keys.length == 1) {
        // nothing more to consume, just commit the last chunk and return it
        // so as to not have an empty element at the end of the result
        return tree['']
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

    final subtree = nextSubtree(tree, remaining[0]);

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
/*
export function applyMapping(string, mapping, convertEnding) {
  const root = mapping;

  function nextSubtree(tree, nextChar) {
    const subtree = tree[nextChar];
    if (subtree === undefined) {
      return undefined;
    }
    // if the next child node does not have a node value, set its node value to the input
    return Object.assign({ '': tree[''] + nextChar }, tree[nextChar]);
  }

  function newChunk(remaining, currentCursor) {
    // start parsing a new chunk
    const firstChar = remaining.charAt(0);

    return parse(
      Object.assign({ '': firstChar }, root[firstChar]),
      remaining.slice(1),
      currentCursor,
      currentCursor + 1
    );
  }

  function parse(tree, remaining, lastCursor, currentCursor) {
    if (!remaining) {
      if (convertEnding || Object.keys(tree).length === 1) {
        // nothing more to consume, just commit the last chunk and return it
        // so as to not have an empty element at the end of the result
        return tree[''] ? [[lastCursor, currentCursor, tree['']]] : [];
      }
      // if we don't want to convert the ending, because there are still possible continuations
      // return null as the final node value
      return [[lastCursor, currentCursor, null]];
    }

    if (Object.keys(tree).length === 1) {
      return [[lastCursor, currentCursor, tree['']]].concat(newChunk(remaining, currentCursor));
    }

    const subtree = nextSubtree(tree, remaining.charAt(0));

    if (subtree === undefined) {
      return [[lastCursor, currentCursor, tree['']]].concat(newChunk(remaining, currentCursor));
    }
    // continue current branch
    return parse(subtree, remaining.slice(1), lastCursor, currentCursor + 1);
  }

  return newChunk(string, 0);
}
*/
