import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_hiragana.dart';

bool isHiragana([String input = '']) {
  if (isEmpty(input)) return false;
  return input.split('').every(isCharHiragana);
}
