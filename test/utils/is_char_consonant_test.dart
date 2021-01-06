import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_consonant.dart';

void main() {
  group('isCharConsonant', () {
    test('sane default', () => expect(isCharConsonant(), equals(false)));
    test('passes parameter tests', () {
      'bcdfghjklmnpqrstvwxyz'.split('').forEach((consonant) {
        expect(isCharConsonant(consonant), equals(true));
      });

      expect(isCharConsonant('a'), equals(false));
      expect(isCharConsonant('!'), equals(false));
      expect(isCharConsonant(''), equals(false));
    });
    test('exclude y', () {
      expect(isCharConsonant('y', false /* excludes 'y' as a consonant */),
          equals(false));
    });
  });
}
