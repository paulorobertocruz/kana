import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_upper_case.dart';

void main() {
  group('isCharKatakana', () {
    test('sane defaults', () {
      expect(isCharUpperCase(), equals(false));
      expect(isCharUpperCase(''), equals(false));
    });
    test('passes parameter tests', () {
      expect(isCharUpperCase('A'), equals(true));
      expect(isCharUpperCase('D'), equals(true));
      expect(isCharUpperCase('-'), equals(false));
      expect(isCharUpperCase('ー'), equals(false));
      expect(isCharUpperCase('a'), equals(false));
      expect(isCharUpperCase('d'), equals(false));
    });
  });
}
