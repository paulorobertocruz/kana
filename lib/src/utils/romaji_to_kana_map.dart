import 'dart:convert';
import 'package:kana/src/utils/kana_mapping.dart'
    show transform, getSubTreeOf, createCustomMapping;

// NOTE: not exactly kunrei shiki, for example ぢゃ -> dya instead of zya, to avoid name clashing
const BASIC_KUNREI = {
  'a': 'あ',
  'i': 'い',
  'u': 'う',
  'e': 'え',
  'o': 'お',
  'k': {
    'a': 'か',
    'i': 'き',
    'u': 'く',
    'e': 'け',
    'o': 'こ',
  },
  's': {
    'a': 'さ',
    'i': 'し',
    'u': 'す',
    'e': 'せ',
    'o': 'そ',
  },
  't': {
    'a': 'た',
    'i': 'ち',
    'u': 'つ',
    'e': 'て',
    'o': 'と',
  },
  'n': {
    'a': 'な',
    'i': 'に',
    'u': 'ぬ',
    'e': 'ね',
    'o': 'の',
  },
  'h': {
    'a': 'は',
    'i': 'ひ',
    'u': 'ふ',
    'e': 'へ',
    'o': 'ほ',
  },
  'm': {
    'a': 'ま',
    'i': 'み',
    'u': 'む',
    'e': 'め',
    'o': 'も',
  },
  'y': {'a': 'や', 'u': 'ゆ', 'o': 'よ'},
  'r': {
    'a': 'ら',
    'i': 'り',
    'u': 'る',
    'e': 'れ',
    'o': 'ろ',
  },
  'w': {
    'a': 'わ',
    'i': 'ゐ',
    'e': 'ゑ',
    'o': 'を',
  },
  'g': {
    'a': 'が',
    'i': 'ぎ',
    'u': 'ぐ',
    'e': 'げ',
    'o': 'ご',
  },
  'z': {
    'a': 'ざ',
    'i': 'じ',
    'u': 'ず',
    'e': 'ぜ',
    'o': 'ぞ',
  },
  'd': {
    'a': 'だ',
    'i': 'ぢ',
    'u': 'づ',
    'e': 'で',
    'o': 'ど',
  },
  'b': {
    'a': 'ば',
    'i': 'び',
    'u': 'ぶ',
    'e': 'べ',
    'o': 'ぼ',
  },
  'p': {
    'a': 'ぱ',
    'i': 'ぴ',
    'u': 'ぷ',
    'e': 'ぺ',
    'o': 'ぽ',
  },
  'v': {
    'a': 'ゔぁ',
    'i': 'ゔぃ',
    'u': 'ゔ',
    'e': 'ゔぇ',
    'o': 'ゔぉ',
  },
};

const SPECIAL_SYMBOLS = {
  '.': '。',
  ',': '、',
  ':': '：',
  '/': '・',
  '!': '！',
  '?': '？',
  '~': '〜',
  '-': 'ー',
  '‘': '「',
  '’': '」',
  '“': '『',
  '”': '』',
  '[': '［',
  ']': '］',
  '(': '（',
  ')': '）',
  '{': '｛',
  '}': '｝',
};

const CONSONANTS = {
  'k': 'き',
  's': 'し',
  't': 'ち',
  'n': 'に',
  'h': 'ひ',
  'm': 'み',
  'r': 'り',
  'g': 'ぎ',
  'z': 'じ',
  'd': 'ぢ',
  'b': 'び',
  'p': 'ぴ',
  'v': 'ゔ',
  'q': 'く',
  'f': 'ふ',
};
const SMALL_Y = {'ya': 'ゃ', 'yi': 'ぃ', 'yu': 'ゅ', 'ye': 'ぇ', 'yo': 'ょ'};
const SMALL_VOWELS = {'a': 'ぁ', 'i': 'ぃ', 'u': 'ぅ', 'e': 'ぇ', 'o': 'ぉ'};

// typing one should be the same as having typed the other instead
const ALIASES = {
  'sh': 'sy', // sha -> sya
  'ch': 'ty', // cho -> tyo
  'cy': 'ty', // cyo -> tyo
  'chy': 'ty', // chyu -> tyu
  'shy': 'sy', // shya -> sya
  'j': 'zy', // ja -> zya
  'jy': 'zy', // jye -> zye

  // exceptions to above rules
  'shi': 'si',
  'chi': 'ti',
  'tsu': 'tu',
  'ji': 'zi',
  'fu': 'hu',
};

// xtu -> っ
final SMALL_LETTERS = {
  'tu': 'っ',
  'wa': 'ゎ',
  'ka': 'ヵ',
  'ke': 'ヶ',
}
  ..addAll(SMALL_VOWELS)
  ..addAll(SMALL_Y);

// don't follow any notable patterns
const SPECIAL_CASES = {
  'yi': 'い',
  'wu': 'う',
  'ye': 'いぇ',
  'wi': 'うぃ',
  'we': 'うぇ',
  'kwa': 'くぁ',
  'whu': 'う',
  // because it's not thya for てゃ but tha
  // and tha is not てぁ, but てゃ
  'tha': 'てゃ',
  'thu': 'てゅ',
  'tho': 'てょ',
  'dha': 'でゃ',
  'dhu': 'でゅ',
  'dho': 'でょ',
};

const AIUEO_CONSTRUCTIONS = {
  'wh': 'う',
  'qw': 'く',
  'q': 'く',
  'gw': 'ぐ',
  'sw': 'す',
  'ts': 'つ',
  'th': 'て',
  'tw': 'と',
  'dh': 'で',
  'dw': 'ど',
  'fw': 'ふ',
  'f': 'ふ',
};

createRomajiToKanaMap() {
  final kanaTree = transform(BASIC_KUNREI);
  // pseudo partial application
  Map<dynamic, dynamic> subtreeOf (string) => getSubTreeOf(kanaTree, string);

  // add tya, sya, etc.
  CONSONANTS.entries.forEach((e) {
    var consonant = e.key;
    var yKana = e.value;
    SMALL_Y.entries.forEach((ee) {
      var roma = ee.key;
      var kana = ee.value;
      // for example kyo -> き + ょ
      subtreeOf(consonant + roma)[''] = yKana + kana;
    });
  });

  SPECIAL_SYMBOLS.entries.forEach((item) {    
    subtreeOf(item.key)[''] = item.value;
  });

  // things like うぃ, くぃ, etc.
  AIUEO_CONSTRUCTIONS.entries.forEach((e) {
    var consonant = e.key;
    var aiueoKana = e.value;
    SMALL_VOWELS.entries.forEach((ee) {
      var vowel = ee.key;
      var kana = ee.value;
      final subtree = subtreeOf(consonant + vowel);
      subtree[''] = aiueoKana + kana;
    });
  });

  // different ways to write ん
  ['n', "n'", 'xn'].forEach((nChar) {
    subtreeOf(nChar)[''] = 'ん';
  });

  // c is equivalent to k, but not for chi, cha, etc. that's why we have to make a copy of k
  kanaTree['c'] = json.decode(json.encode(kanaTree['k']));

  ALIASES.entries.forEach((e) {
    String string = e.key;
    var alternative = e.value;
    final allExceptLast = string.substring(0, string.length - 1);
    final last = string.codeUnitAt(string.length - 1);
    final parentTree = subtreeOf(allExceptLast);
    // copy to avoid recursive containment
    parentTree[String.fromCharCode(last)] = json.decode(json.encode(subtreeOf(alternative)));
  });

  List getAlternatives(string) {
    return [
      ...ALIASES.entries,
      ...[
        ['c', 'k']
      ]
    ].reduce((list, e) {
      List llist = list as List;
      List le = e as List;
      return string.startsWith(le[1])
          ? llist.addAll(string.replace(le[1], le[0]))
          : llist;
    });
  }

  SMALL_LETTERS.entries.forEach((e) {
    final kunreiRoma = e.key;
    final kana = e.value;
    final last = (String char) => String.fromCharCode(char.codeUnitAt(char.length - 1));
    final allExceptLast = (String chars) => chars.substring(0, chars.length - 1);
    final xRoma = 'x${kunreiRoma}';
    final xSubtree = subtreeOf(xRoma);
    xSubtree[''] = kana;

    // ltu -> xtu -> っ
    final parentTree = subtreeOf('l${allExceptLast(kunreiRoma)}');
    parentTree[last(kunreiRoma)] = xSubtree;

    // ltsu -> ltu -> っ
    getAlternatives(kunreiRoma).forEach((altRoma) {
      ['l', 'x'].forEach((prefix) {
        final altParentTree = subtreeOf(prefix + allExceptLast(altRoma));
        altParentTree[last(altRoma)] = subtreeOf(prefix + kunreiRoma);
      });
    });
  });

  SPECIAL_CASES.entries.forEach(([string, kana]) {
    subtreeOf(string)[''] = kana;
  });

  // add kka, tta, etc.
  addTsu(tree) {
    return tree.entries.reduce((tsuTree, [key, value]) {
      if (!key) {
        // we have reached the bottom of this branch
        tsuTree[key] = 'っ${value}';
      } else {
        // more subtrees
        tsuTree[key] = addTsu(value);
      }
      return tsuTree;
    }, {});
  }

  // have to explicitly name c here, because we made it a copy of k, not a reference
  [...CONSONANTS.keys, 'c', 'y', 'w', 'j'].forEach((consonant) {
    final subtree = kanaTree[consonant];
    subtree[consonant] = addTsu(subtree);
  });
  // nn should not be っん
  kanaTree['n'].remove('n');
  // solidify the results, so that there there is referential transparency within the tree
  return json.decode(json.encode(kanaTree));
}

var romajiToKanaMap = null;

getRomajiToKanaTree() {
  if (romajiToKanaMap == null) {
    romajiToKanaMap = createRomajiToKanaMap();
  }
  return romajiToKanaMap;
}

final USE_OBSOLETE_KANA_MAP = createCustomMapping({'wi': 'ゐ', 'we': 'ゑ'});

IME_MODE_MAP(map) {
  // in IME mode, we do not want to convert single ns
  final mapCopy = json.decode(json.encode(map));
  mapCopy.n.n = {'': 'ん'};
  mapCopy.n[' '] = {'': 'ん'};
  return mapCopy;
}
