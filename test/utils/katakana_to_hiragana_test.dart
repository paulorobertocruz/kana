import 'package:test/test.dart';
import 'package:kana/src/utils/katakana_to_hiragana.dart';
import 'package:kana/src/to_romaji.dart';

void main() {
  group('katakanaToHiragana', () {
    test('sane default', () {
      expect(katakanaToHiragana(), equals(''));
    });
    test('passes parameter tests pure', () {
      expect(katakanaToHiragana('ヒラガナ', toRomaji), equals('ひらがな'));      
    });
    test('passes parameter tests mixed', () {
      expect(katakanaToHiragana('ヒラガナ is a type of kana', toRomaji),
          equals('ひらがな is a type of kana'));
    });
  });
}
