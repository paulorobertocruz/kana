import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_kana.dart';

bool isKana(String input) {
  if (isEmpty(input)) return false;
  return input.split('').every(isCharKana);
}
