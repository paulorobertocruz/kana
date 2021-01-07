import 'package:kana/src/constants.dart' show KATAKANA_START, HIRAGANA_START;
import 'package:kana/src/utils/is_char_long_dash.dart';
import 'package:kana/src/utils/is_char_slash_dot.dart';
import 'package:kana/src/utils/is_char_katakana.dart';
import 'package:kana/src/utils/is_empty.dart';

bool isCharInitialLongDash(char, index) => isCharLongDash(char) && index < 1;
final isCharInnerLongDash = (char, index) => isCharLongDash(char) && index > 0;
final isKanaAsSymbol = (char) => ['ヶ', 'ヵ'].contains(char);

final LONG_VOWELS = {
  'a': 'あ',
  'i': 'い',
  'u': 'う',
  'e': 'え',
  'o': 'う',
};

// inject toRomaji to avoid circular dependency between toRomaji <-> katakanaToHiragana
String katakanaToHiragana(
    [String input = '',
    String Function(String) toRomaji,
    bool isDestinationRomaji]) {
  String previousKana = '';
  return input.split('').asMap().entries.fold([], (hira, entry) {    
    int index = entry.key;
    String char = entry.value;
    // Short circuit to avoid incorrect codeshift for 'ー' and '・'
    if (isCharSlashDot(char) ||
        isCharInitialLongDash(char, index) ||
        isKanaAsSymbol(char)) {
      return hira..addAll(char.split(''));
      // Transform long vowels: 'オー' to 'おう'
    } else if (!isEmpty(previousKana) && isCharInnerLongDash(char, index)) {
      // Transform previousKana back to romaji, and slice off the vowel
      final romaji = toRomaji(previousKana).substring(-1);
      // However, ensure 'オー' => 'おお' => 'oo' if this is a transform on the way to romaji
      if (isCharKatakana(input[index - 1]) &&
          romaji == 'o' &&
          isDestinationRomaji) {
        return hira..addAll(['お']);
      }
      return hira..addAll(LONG_VOWELS[romaji].split(''));
    } else if (!isCharLongDash(char) && isCharKatakana(char)) {
      // Shift charcode.
      final code = char.codeUnitAt(0) + (HIRAGANA_START - KATAKANA_START);
      final hiraChar = String.fromCharCode(code);
      previousKana = hiraChar;
      return hira..addAll(hiraChar.split(''));
    }
    // Pass non katakana chars through
    previousKana = '';
    return hira..addAll(char.split(''));
  }).join('');
}
