import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_hiragana.dart';

void main() {
  group('isCharHiragana', () {
    test('sane defaults', () {
      expect(isCharHiragana(), equals(false));
      expect(isCharHiragana(''), equals(false));
    });
    test('passes parameter tests', () {
      expect(isCharHiragana('な'), equals(true));
      expect(isCharHiragana('ナ'), equals(false));
      expect(isCharHiragana('n'), equals(false));
      expect(isCharHiragana('!'), equals(false));
    });
  });
}
