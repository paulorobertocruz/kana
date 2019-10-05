import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_long_dash.dart';
import 'package:kana/src/utils/is_char_in_range.dart';
import 'package:kana/src/constants.dart' show HIRAGANA_START, HIRAGANA_END;

bool isCharHiragana(String char) {
  if (isEmpty(char)) return false;
  if (isCharLongDash(char)) return true;
  return isCharInRange(char, HIRAGANA_START, HIRAGANA_END);
}
