import 'package:kana/src/constants.dart' show KATAKANA_START, HIRAGANA_START;
import 'package:kana/src/utils/is_char_long_dash.dart';
import 'package:kana/src/utils/is_char_slash_dot.dart';
import 'package:kana/src/utils/is_char_katakana.dart';

bool isCharInitialLongDash(char, index) {return isCharLongDash(char) && index < 1;}
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
    String input, String Function(String) toRomaji, [isDestinationRomaji]) {
  String previousKana = '';
  String hira = '';
  String combine(String hira, String char, int index) {
    if (isCharSlashDot(char) ||
        isCharInitialLongDash(char, index) ||
        isKanaAsSymbol(char)) {
      return hira += char;
      // Transform long vowels: 'オー' to 'おう'
    } else if (previousKana != null && isCharInnerLongDash(char, index)) {
      // Transform previousKana back to romaji, and slice off the vowel
      final romaji = toRomaji(previousKana).substring(-1);
      // However, ensure 'オー' => 'おお' => 'oo' if this is a transform on the way to romaji
      if (isCharKatakana(input[index - 1]) &&
          romaji == 'o' &&
          isDestinationRomaji) {
        return hira += 'お';
      }
      return hira += LONG_VOWELS[romaji];
    } else if (!isCharLongDash(char) && isCharKatakana(char)) {
      // Shift charcode.
      final code = char.codeUnitAt(0) + (HIRAGANA_START - KATAKANA_START);
      final hiraChar = String.fromCharCode(code);
      previousKana = hiraChar;
      return hira += hiraChar;
    }
    // Pass non katakana chars through
    previousKana = '';
    return hira += char;
  }

  for (int index = 0; index < input.length; index++) {
    final String char = input[index];
    hira = combine(hira, char, index);
  }

  return hira;
}