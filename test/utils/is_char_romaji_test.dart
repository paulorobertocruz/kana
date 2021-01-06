import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_romaji.dart';

void main() {
  group('isCharKatakana', () {
    test('sane defaults', () {
      expect(isCharRomaji(), equals(false));
    });
    test('passes parameter tests', () {
      expect(isCharRomaji('n'), equals(true));
      expect(isCharRomaji('!'), equals(true));
      expect(isCharRomaji('ナ'), equals(false));
      expect(isCharRomaji('は'), equals(false));
      expect(isCharRomaji('缶'), equals(false));
      expect(isCharRomaji(''), equals(false));
    });
  });
}
