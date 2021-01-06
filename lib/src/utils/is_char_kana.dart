import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_hiragana.dart';
import 'package:kana/src/utils/is_char_katakana.dart';

bool isCharKana([String char]) {
  if (isEmpty(char)) return false;
  return isCharHiragana(char) || isCharKatakana(char);
}
