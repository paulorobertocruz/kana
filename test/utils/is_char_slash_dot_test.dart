import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_slash_dot.dart';

void main() {
  group('isCharKatakana', () {
    test('sane defaults', () {
      expect(isCharSlashDot(), equals(false));
    });
    test('passes parameter tests', () {
      expect(isCharSlashDot('・'), equals(true));
      expect(isCharSlashDot('/'), equals(false));
    });
  });
}
