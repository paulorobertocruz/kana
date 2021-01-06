import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_in_range.dart';
import 'package:kana/src/constants.dart'
    show LATIN_UPPERCASE_START, LATIN_UPPERCASE_END;

bool isCharUpperCase([String char]) {
  if (isEmpty(char)) return false;
  return isCharInRange(char, LATIN_UPPERCASE_START, LATIN_UPPERCASE_END);
}
