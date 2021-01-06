import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_in_range.dart';
import 'package:kana/src/constants.dart' show JA_PUNCTUATION_RANGES;

bool isCharJapanesePunctuation([String char]) {
  if (isEmpty(char)) return false;
  return JA_PUNCTUATION_RANGES
      .any((input) => isCharInRange(char, input[0], input[1]));
}
