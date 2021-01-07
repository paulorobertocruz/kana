import 'package:test/test.dart';
import 'package:kana/src/utils/hiragaka_to_katakana.dart';

void main() {
  group('hiraganaToKatakana', () {
    test('sane default', () {
      expect(hiraganaToKatakana(), equals(''));
    });
    test('passes parameter tests', () {      
      expect(hiraganaToKatakana('ひらがな'), equals('ヒラガナ'));
      expect(hiraganaToKatakana('ひらがな is a type of kana'), equals('ヒラガナ is a type of kana'));
    });
  });
}
