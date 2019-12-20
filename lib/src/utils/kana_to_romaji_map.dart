import 'dart:convert' show json;
import 'package:kana/src/utils/kana_mapping.dart' show transform, getSubTreeOf;
import 'package:kana/src/constants.dart' show ROMANIZATIONS_HEPBURN;

var kanaToHepburnMap = null;

const BASIC_ROMAJI = {
  'あ': 'a',
  'い': 'i',
  'う': 'u',
  'え': 'e',
  'お': 'o',
  'か': 'ka',
  'き': 'ki',
  'く': 'ku',
  'け': 'ke',
  'こ': 'ko',
  'さ': 'sa',
  'し': 'shi',
  'す': 'su',
  'せ': 'se',
  'そ': 'so',
  'た': 'ta',
  'ち': 'chi',
  'つ': 'tsu',
  'て': 'te',
  'と': 'to',
  'な': 'na',
  'に': 'ni',
  'ぬ': 'nu',
  'ね': 'ne',
  'の': 'no',
  'は': 'ha',
  'ひ': 'hi',
  'ふ': 'fu',
  'へ': 'he',
  'ほ': 'ho',
  'ま': 'ma',
  'み': 'mi',
  'む': 'mu',
  'め': 'me',
  'も': 'mo',
  'ら': 'ra',
  'り': 'ri',
  'る': 'ru',
  'れ': 're',
  'ろ': 'ro',
  'や': 'ya',
  'ゆ': 'yu',
  'よ': 'yo',
  'わ': 'wa',
  'ゐ': 'wi',
  'ゑ': 'we',
  'を': 'wo',
  'ん': 'n',
  'が': 'ga',
  'ぎ': 'gi',
  'ぐ': 'gu',
  'げ': 'ge',
  'ご': 'go',
  'ざ': 'za',
  'じ': 'ji',
  'ず': 'zu',
  'ぜ': 'ze',
  'ぞ': 'zo',
  'だ': 'da',
  'ぢ': 'ji',
  'づ': 'zu',
  'で': 'de',
  'ど': 'do',
  'ば': 'ba',
  'び': 'bi',
  'ぶ': 'bu',
  'べ': 'be',
  'ぼ': 'bo',
  'ぱ': 'pa',
  'ぴ': 'pi',
  'ぷ': 'pu',
  'ぺ': 'pe',
  'ぽ': 'po',
  'ゔぁ': 'va',
  'ゔぃ': 'vi',
  'ゔ': 'vu',
  'ゔぇ': 've',
  'ゔぉ': 'vo',
};


const SPECIAL_SYMBOLS = {
  '。': '.',
  '、': ',',
  '：': ':',
  '・': '/',
  '！': '!',
  '？': '?',
  '〜': '~',
  'ー': '-',
  '「': '‘',
  '」': '’',
  '『': '“',
  '』': '”',
  '［': '[',
  '］': ']',
  '（': '(',
  '）': ')',
  '｛': '{',
  '｝': '}',
  '　': ' ',
};

// んい -> n'i
const AMBIGUOUS_VOWELS = ['あ', 'い', 'う', 'え', 'お', 'や', 'ゆ', 'よ'];
const SMALL_Y = {'ゃ': 'ya', 'ゅ': 'yu', 'ょ': 'yo'};
const SMALL_Y_EXTRA = {'ぃ': 'yi', 'ぇ': 'ye'};
const SMALL_AIUEO = {
  'ぁ': 'a',
  'ぃ': 'i',
  'ぅ': 'u',
  'ぇ': 'e',
  'ぉ': 'o',
};
const YOON_KANA = ['き', 'に', 'ひ', 'み', 'り', 'ぎ', 'び', 'ぴ', 'ゔ', 'く', 'ふ'];
const YOON_EXCEPTIONS = {
  'し': 'sh',
  'ち': 'ch',
  'じ': 'j',
  'ぢ': 'j',
};
const SMALL_KANA = {
  'っ': '',
  'ゃ': 'ya',
  'ゅ': 'yu',
  'ょ': 'yo',
  'ぁ': 'a',
  'ぃ': 'i',
  'ぅ': 'u',
  'ぇ': 'e',
  'ぉ': 'o',
};

// going with the intuitive (yet incorrect) solution where っや -> yya and っぃ -> ii
// in other words, just assume the sokuon could have been applied to anything
const SOKUON_WHITELIST = {
  'b': 'b',
  'c': 't',
  'd': 'd',
  'f': 'f',
  'g': 'g',
  'h': 'h',
  'j': 'j',
  'k': 'k',
  'm': 'm',
  'p': 'p',
  'q': 'q',
  'r': 'r',
  's': 's',
  't': 't',
  'v': 'v',
  'w': 'w',
  'x': 'x',
  'z': 'z',
};

getKanaToHepburnTree() {
  if (kanaToHepburnMap == null) {
    kanaToHepburnMap = createKanaToHepburnMap();
  }
  return kanaToHepburnMap;
}

getKanaToRomajiTree(fullOptions) {
  switch (fullOptions.romanization) {
    case ROMANIZATIONS_HEPBURN:
      return getKanaToHepburnTree();
    default:
      return {};
  }
}

createKanaToHepburnMap() {
  final romajiTree = transform(BASIC_ROMAJI);

  final subtreeOf = (string) => getSubTreeOf(romajiTree, string);
  final setTrans = (string, transliteration) {
    subtreeOf(string)[''] = transliteration;
  };

  SPECIAL_SYMBOLS.entries.forEach((e) {
    final jsymbol = e.key;
    final symbol = e.value;
    subtreeOf(jsymbol)[''] = symbol;
  });

  [...SMALL_Y.entries, ...SMALL_AIUEO.entries].forEach(([roma, kana]) {
    setTrans(roma, kana);
  });

  // きゃ -> kya
  YOON_KANA.forEach((kana) {
    final firstRomajiChar = subtreeOf(kana)[''][0];
    SMALL_Y.entries.forEach((e) {
      var yKana = e.key;
      var yRoma = e.value;
      setTrans(kana + yKana, firstRomajiChar + yRoma);
    });
    // きぃ -> kyi
    SMALL_Y_EXTRA.entries.forEach((e) {
      var yKana = e.key;
      var yRoma = e.value;
      setTrans(kana + yKana, firstRomajiChar + yRoma);
    });
  });

  YOON_EXCEPTIONS.entries.forEach((e) {
    var kana = e.key;
    var roma = e.value;
    // じゃ -> ja
    SMALL_Y.entries.forEach((e) {
      var yKana = e.key;
      var yRoma = e.value;
      setTrans(kana + yKana, roma + yRoma[1]);
    });
    // じぃ -> jyi, じぇ -> je
    setTrans('${kana}ぃ', '${roma}yi');
    setTrans('${kana}ぇ', '${roma}e');
  });

  romajiTree['っ'] = resolveTsu(romajiTree);

  SMALL_KANA.entries.forEach((e) {
    var kana = e.key;
    var roma = e.value;
    setTrans(kana, roma);
  });

  AMBIGUOUS_VOWELS.forEach((kana) {
    setTrans('ん${kana}', 'n${subtreeOf(kana)['']}');
  });

  // NOTE: could be re-enabled with an option?
  // // んば -> mbo
  // const LABIAL = [
  //   'ば', 'び', 'ぶ', 'べ', 'ぼ',
  //   'ぱ', 'ぴ', 'ぷ', 'ぺ', 'ぽ',
  //   'ま', 'み', 'む', 'め', 'も',
  // ];
  // LABIAL.forEach((kana) => {
  //   setTrans('ん${kana}', 'm${subtreeOf(kana)['']}');
  // });

  return json.decode(json.encode(romajiTree));
}

resolveTsu(tree) {
  return tree.entries.reduce((tsuTree, [key, value]) {
    if (!key) {
      // we have reached the bottom of this branch
      final consonant = value.charAt(0);
      tsuTree[key] = SOKUON_WHITELIST.keys.contains(consonant)
          ? SOKUON_WHITELIST[consonant] + value
          : value;
    } else {
      // more subtrees
      tsuTree[key] = resolveTsu(value);
    }
    return tsuTree;
  }, {});
}
