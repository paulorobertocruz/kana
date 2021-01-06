import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_kana.dart';

void main() {
  group('isCharKana', () {
    test('sane default', () {
      expect(isCharKana(), equals(false));
      expect(isCharKana(''), equals(false));
    });
    test('passes parameter tests', () {
      expect(isCharKana('は'), equals(true));
      expect(isCharKana('ナ'), equals(true));
      expect(isCharKana('n'), equals(false));
      expect(isCharKana('!'), equals(false));
      expect(isCharKana('-'), equals(false));
      expect(isCharKana('ー'), equals(true));
    });
  });
}
