import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_kanji.dart';

bool isKanji(String input) {
  if (isEmpty(input)) return false;
  return input.split('').every(isCharKanji);
}
