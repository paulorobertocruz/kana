import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_in_range.dart';
import 'package:kana/src/constants.dart' show KATAKANA_START, KATAKANA_END;

bool isCharKatakana([String char]) {
  if (isEmpty(char)) return false;
  return isCharInRange(char, KATAKANA_START, KATAKANA_END);
}
