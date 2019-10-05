import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_romaji.dart';

bool isRomaji(input, [allowed]) {
  final augmented = allowed is RegExp;
  return isEmpty(input)
      ? false
      : input.split('').every((char) {
          final isRoma = isCharRomaji(char);
          return !augmented ? isRoma : isRoma || allowed.test(char);
        });
}
