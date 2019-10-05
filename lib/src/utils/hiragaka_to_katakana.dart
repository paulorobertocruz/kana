import 'package:kana/src/utils/is_char_long_dash.dart';
import 'package:kana/src/utils/is_char_slash_dot.dart';
import 'package:kana/src/utils/is_char_hiragana.dart';
import 'package:kana/src/constants.dart' show HIRAGANA_START, KATAKANA_START;

String hiraganaToKatakana(String input) {
  final kata = [];
  input.split("").forEach((c) {
    if (isCharLongDash(c) || isCharSlashDot(c)) {
      kata.add(c);
    } else if (isCharHiragana(c)) {
      final code = c.codeUnitAt(0) + (KATAKANA_START - HIRAGANA_START);
      final kataChar = String.fromCharCode(code);
      kata.add(kataChar);
    } else {
      kata.add(c);
    }
  });
  return kata.join("");
}
