import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_english_punctuation.dart';
import 'package:kana/src/utils/is_char_japanese_punctuation.dart';

bool isCharPunctuation(String char) {
  if (isEmpty(char)) return false;
  return isCharEnglishPunctuation(char) || isCharJapanesePunctuation(char);
}
