import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_vowel.dart';

void main() {
  group('isCharKatakana', () {
    test('sane defaults', () {
      expect(isCharVowel(), equals(false));
    });
    test('passes parameter tests', () {
      'aeiou'
          .split('')
          .forEach((vowel) => expect(isCharVowel(vowel), equals(true)));
      expect(isCharVowel('y'),
          equals(true)); /* includes 'y' as a vowel by default */
      expect(
          isCharVowel('y', false), equals(false)); /* excludes 'y' as a vowel */
      expect(isCharVowel('x'), equals(false));
      expect(isCharVowel('!'), equals(false));
      expect(isCharVowel(''), equals(false));
    });
  });
}
