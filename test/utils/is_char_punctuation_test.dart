import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_punctuation.dart';
import 'package:kana/src/helpers/conversion_tables.dart' show JA_PUNC, EN_PUNC;

void main() {
  group('isCharKatakana', () {
    test('sane defaults', () {
      expect(isCharPunctuation(), equals(false));
      expect(isCharPunctuation(''), equals(false));
    });
    test('passes parameter tests', () {
      expect(JA_PUNC.every((char) => isCharPunctuation(char)), equals(true));
      expect(EN_PUNC.every((char) => isCharPunctuation(char)), equals(true));
      expect(isCharPunctuation(' '), equals(true));
      expect(isCharPunctuation('　'), equals(true));
      expect(isCharPunctuation('a'), equals(false));
      expect(isCharPunctuation('ふ'), equals(false));
      expect(isCharPunctuation('字'), equals(false));
      expect(isCharPunctuation(''), equals(false));
    });
  });
}
