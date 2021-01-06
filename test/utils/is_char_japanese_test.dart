import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_japanese.dart';

void main() {
  group('isCharJapanese', () {
    test('sane defaults', () {
      expect(isCharJapanese(), equals(false));
      expect(isCharJapanese(''), equals(false));
    });

    test('passes parameter tests', () {
      expect(isCharJapanese('１'), equals(true));
      expect(isCharJapanese('ナ'), equals(true));
      expect(isCharJapanese('は'), equals(true));
      expect(isCharJapanese('缶'), equals(true));
      expect(isCharJapanese('〜'), equals(true));
      expect(isCharJapanese('ｎ'), equals(true));
      expect(isCharJapanese('Ｋ'), equals(true));
      expect(isCharJapanese('1'), equals(false));
      expect(isCharJapanese('n'), equals(false));
      expect(isCharJapanese('K'), equals(false));
      expect(isCharJapanese('!'), equals(false));
    });
  });
}
