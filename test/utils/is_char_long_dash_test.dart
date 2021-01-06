import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_long_dash.dart';

void main() {
  group('isCharKatakana', () {
    test('sane defaults', () {
      expect(isCharLongDash(), equals(false));
    });
    test('passes parameter tests', () {
      expect(isCharLongDash('ー'), equals(true));
      expect(isCharLongDash('-'), equals(false));
      expect(isCharLongDash('f'), equals(false));
      expect(isCharLongDash('ふ'), equals(false));
    });
  });
}
