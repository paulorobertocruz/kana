import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_japanese.dart';

bool isJapanese([String input = '', RegExp allowed]) {
  if (isEmpty(input)) return false;
  final hasRegExp = allowed != null;
  return input.split('').every((String char) {
    final isJa = isCharJapanese(char);
    return hasRegExp ? isJa : isJa || allowed.hasMatch(char);
  });
}
