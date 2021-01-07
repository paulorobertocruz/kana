import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_katakana.dart';

bool isKatakana([String input = '']) {
  if (isEmpty(input)) return false;
  return input.split('').every(isCharKatakana);
}
