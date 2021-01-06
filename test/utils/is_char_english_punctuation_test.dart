import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_english_punctuation.dart';
import 'package:kana/src/helpers/conversion_tables.dart' show JA_PUNC, EN_PUNC;

void main() {
  group('isCharEnglishPunctuation', () {
    test('sane defaults', () {
      expect(isCharEnglishPunctuation(), equals(false));
      expect(isCharEnglishPunctuation(''), equals(false));
    });

    test('passes parameter tests', () {
      expect(EN_PUNC.every((char) => isCharEnglishPunctuation(char)),
          equals(true));
      expect(JA_PUNC.every((char) => isCharEnglishPunctuation(char)),
          equals(false));
      expect(isCharEnglishPunctuation(' '), equals(true));
      expect(isCharEnglishPunctuation('a'), equals(false));
      expect(isCharEnglishPunctuation('ふ'), equals(false));
      expect(isCharEnglishPunctuation('字'), equals(false));
    });
  });
}
