import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_katakana.dart';

void main() {
  group('isCharKatakana', () {
    test('sane defaults', () {
      expect(isCharKatakana(), equals(false));
      expect(isCharKatakana(''), equals(false));
    });
    test('passes parameter tests', () {
      expect(isCharKatakana('ナ'), equals(true));
      expect(isCharKatakana('は'), equals(false));
      expect(isCharKatakana('n'), equals(false));
      expect(isCharKatakana('!'), equals(false));
    });
  });
}
