import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_kanji.dart';

void main() {
  group('isCharKatakana', () {
    test('sane defaults', () {
      expect(isCharKanji(), equals(false));
      expect(isCharKanji(''), equals(false));
    });
    test('passes parameter tests', () {
      expect(isCharKanji('腹'), equals(true));
      expect(
          isCharKanji('一'), equals(true)); // kanji for いち・1 - not a long hyphen
      expect(isCharKanji('ー'), equals(false)); // long hyphen
      expect(isCharKanji('は'), equals(false));
      expect(isCharKanji('ナ'), equals(false));
      expect(isCharKanji('n'), equals(false));
      expect(isCharKanji('!'), equals(false));
      expect(isCharKanji(''), equals(false));
    });
  });
}
