import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_romaji.dart';

bool isRomaji([String input = '', RegExp allowed]) {
  final hasAllowed = allowed != null;
  if (isEmpty(input)) return false;
  return input.split('').every((char) {
    final isRoma = isCharRomaji(char);
    return !hasAllowed ? isRoma : isRoma || allowed.hasMatch(char);
  });
}
