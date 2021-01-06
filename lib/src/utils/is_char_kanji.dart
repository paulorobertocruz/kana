import 'package:kana/src/utils/is_char_in_range.dart';
import 'package:kana/src/constants.dart' show KANJI_START, KANJI_END;

bool isCharKanji([String char]) {
  return isCharInRange(char, KANJI_START, KANJI_END);
}
