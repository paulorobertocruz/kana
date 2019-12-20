import 'package:kana/src/utils/is_empty.dart' show isEmpty;
import 'package:kana/src/utils/is_char_english_punctuation.dart'
    show isCharEnglishPunctuation;
import 'package:kana/src/utils/is_char_japanese_punctuation.dart'
    show isCharJapanesePunctuation;
import 'package:kana/src/utils/is_char_romaji.dart' show isCharRomaji;
import 'package:kana/src/utils/is_char_kanji.dart' show isCharKanji;
import 'package:kana/src/utils/is_char_hiragana.dart' show isCharHiragana;
import 'package:kana/src/utils/is_char_katakana.dart' show isCharKatakana;
import 'package:kana/src/utils/is_char_japanese.dart' show isCharJapanese;

bool isCharEnSpace(x) => x == ' ';
bool isCharJaSpace(x) => x == '　';
bool isCharJaNum(x) => RegExp("[０-９]").hasMatch(x);
bool isCharEnNum(x) => RegExp("[0-9]").hasMatch(x);

enum TOKEN_TYPES_ENUM {
  EN,
  JA,
  EN_NUM,
  JA_NUM,
  EN_PUNC,
  JA_PUNC,
  KANJI,
  HIRAGANA,
  KATAKANA,
  SPACE,
  OTHER
}

//export
const TOKEN_TYPES = {
  TOKEN_TYPES_ENUM.EN: 'en',
  TOKEN_TYPES_ENUM.JA: 'ja',
  TOKEN_TYPES_ENUM.EN_NUM: 'englishNumeral',
  TOKEN_TYPES_ENUM.JA_NUM: 'japaneseNumeral',
  TOKEN_TYPES_ENUM.EN_PUNC: 'englishPunctuation',
  TOKEN_TYPES_ENUM.JA_PUNC: 'japanesePunctuation',
  TOKEN_TYPES_ENUM.KANJI: 'kanji',
  TOKEN_TYPES_ENUM.HIRAGANA: 'hiragana',
  TOKEN_TYPES_ENUM.KATAKANA: 'katakana',
  TOKEN_TYPES_ENUM.SPACE: 'space',
  TOKEN_TYPES_ENUM.OTHER: 'other',
};

// export
String getType(input, [bool compact = false]) {
  if (compact) {
    if (isCharJaNum(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.OTHER];
    if (isCharEnNum(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.OTHER];
    if (isCharEnSpace(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.EN];
    if (isCharEnglishPunctuation(input))
      return TOKEN_TYPES[TOKEN_TYPES_ENUM.OTHER];
    if (isCharJaSpace(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.JA];
    if (isCharJapanesePunctuation(input))
      return TOKEN_TYPES[TOKEN_TYPES_ENUM.OTHER];
    if (isCharJapanese(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.JA];
    if (isCharRomaji(input))
      return TOKEN_TYPES[TOKEN_TYPES_ENUM.EN];
    else
      return TOKEN_TYPES[TOKEN_TYPES_ENUM.OTHER];
  } else {
    if (isCharJaSpace(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.SPACE];
    if (isCharEnSpace(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.SPACE];
    if (isCharJaNum(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.JA_NUM];
    if (isCharEnNum(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.EN_NUM];
    if (isCharEnglishPunctuation(input))
      return TOKEN_TYPES[TOKEN_TYPES_ENUM.EN_PUNC];
    if (isCharJapanesePunctuation(input))
      return TOKEN_TYPES[TOKEN_TYPES_ENUM.JA_PUNC];
    if (isCharKanji(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.KANJI];
    if (isCharHiragana(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.HIRAGANA];
    if (isCharKatakana(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.KATAKANA];
    if (isCharJapanese(input)) return TOKEN_TYPES[TOKEN_TYPES_ENUM.JA];
    if (isCharRomaji(input))
      return TOKEN_TYPES[TOKEN_TYPES_ENUM.EN];
    else
      return TOKEN_TYPES[TOKEN_TYPES_ENUM.OTHER];
  }
}

/**
 * Splits input into array of strings separated by opinionated token types
 * `'en', 'ja', 'englishNumeral', 'japaneseNumeral','englishPunctuation', 'japanesePunctuation','kanji', 'hiragana', 'katakana', 'space', 'other'`.
 * If `{ compact: true }` then many same-language tokens are combined (spaces + text, kanji + kana, numeral + punctuation).
 * If `{ detailed: true }` then return array will contain `{ type, value }` instead of `'value'`
 * @param  {String} input text
 * @param  {Object} [options={ compact: false, detailed: false}] options to modify output style
 * @return {String|Object[]} text split into tokens containing values, or detailed object
 * @example
 * tokenize('ふふフフ')
 * // ['ふふ', 'フフ']
 *
 * tokenize('感じ')
 * // ['感', 'じ']
 *
 * tokenize('truly 私は悲しい')
 * // ['truly', ' ', '私', 'は', '悲', 'しい']
 *
 * tokenize('truly 私は悲しい', { compact: true })
 * // ['truly ', '私は悲しい']
 *
 * tokenize('5romaji here...!?漢字ひらがな４カタ　カナ「ＳＨＩＯ」。！')
 * // [ '5', 'romaji', ' ', 'here', '...!?', '漢字', 'ひらがな', 'カタ', '　', 'カナ', '４', '「', 'ＳＨＩＯ', '」。！']
 *
 * tokenize('5romaji here...!?漢字ひらがな４カタ　カナ「ＳＨＩＯ」。！', { compact: true })
 * // [ '5', 'romaji here', '...!?', '漢字ひらがなカタ　カナ', '４「', 'ＳＨＩＯ', '」。！']
 *
 * tokenize('5romaji here...!?漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب', { detailed: true })
 * // [
 *  { type: 'englishNumeral', value: '5' },
 *  { type: 'en', value: 'romaji' },
 *  { type: 'space', value: ' ' },
 *  { type: 'en', value: 'here' },
 *  { type: 'englishPunctuation', value: '...!?' },
 *  { type: 'kanji', value: '漢字' },
 *  { type: 'hiragana', value: 'ひらがな' },
 *  { type: 'katakana', value: 'カタ' },
 *  { type: 'space', value: '　' },
 *  { type: 'katakana', value: 'カナ' },
 *  { type: 'japaneseNumeral', value: '４' },
 *  { type: 'japanesePunctuation', value: '「' },
 *  { type: 'ja', value: 'ＳＨＩＯ' },
 *  { type: 'japanesePunctuation', value: '」。！' },
 *  { type: 'space', value: ' ' },
 *  { type: 'other', value: 'لنذهب' },
 * ]
 *
 * tokenize('5romaji here...!?漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب', { compact: true, detailed: true})
 * // [
 *  { type: 'other', value: '5' },
 *  { type: 'en', value: 'romaji here' },
 *  { type: 'other', value: '...!?' },
 *  { type: 'ja', value: '漢字ひらがなカタ　カナ' },
 *  { type: 'other', value: '４「' },
 *  { type: 'ja', value: 'ＳＨＩＯ' },
 *  { type: 'other', value: '」。！' },
 *  { type: 'en', value: ' ' },
 *  { type: 'other', value: 'لنذهب' },
 *]
 */
//export
List tokenize(String input, {bool compact = false, bool detailed = false}) {
  if (isEmpty(input)) return [];
  List<String> chars = List.from(input.split(""), growable: true);
  var initialData = chars.removeAt(0);
  var prevType = getType(initialData, compact);

  var initial = [
    detailed ? {"type": prevType, "value": initialData} : initialData
  ];

  var result = chars.fold(initial, (tokens, char) {
    var currType = getType(char, compact);
    var sameType = currType == prevType;
    prevType = currType;
    var newValue = char;
    if (sameType) {
      newValue =
          (detailed ? tokens.removeLast()["value"] : tokens.removeLast()) +
              newValue;
    }
    if (detailed)
      tokens.add({"type": currType, "value": newValue});
    else
      tokens.add(newValue);
    return tokens;
  });
  return result;
}
