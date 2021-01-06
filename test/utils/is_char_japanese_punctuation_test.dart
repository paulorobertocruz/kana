import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_japanese_punctuation.dart';
import 'package:kana/src/helpers/conversion_tables.dart' show JA_PUNC, EN_PUNC;

void main() {
  group('isCharJapanese', () {
    test('sane defaults', () {
      expect(isCharJapanesePunctuation(), equals(false));
      expect(isCharJapanesePunctuation(''), equals(false));
    });

    test('passes parameter tests', () {
      expect(JA_PUNC.every((char) => isCharJapanesePunctuation(char)),
          equals(true));
      expect(EN_PUNC.every((char) => isCharJapanesePunctuation(char)),
          equals(false));
      expect(isCharJapanesePunctuation('　'), equals(true));
      expect(isCharJapanesePunctuation('?'), equals(false));
      expect(isCharJapanesePunctuation('a'), equals(false));
      expect(isCharJapanesePunctuation('ふ'), equals(false));
      expect(isCharJapanesePunctuation('字'), equals(false));
    });
  });
}
