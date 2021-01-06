import 'package:test/test.dart';
import 'package:kana/src/helpers/conversion_tables.dart'
    show ROMA_TO_HIRA_KATA, HIRA_KATA_TO_ROMA;
import 'package:kana/kana.dart' show toRomaji, toKana, toHiragana, toKatakana;
import 'package:kana/src/utils/is_empty.dart' as kana;

void main() {
  group('character conversions', () {
    group('test every conversion table char', () {
      group('toKana()', () {
        ROMA_TO_HIRA_KATA.forEach((item) {
          final romaji = item[0];
          final hiragana = item[1];
          final katakana = item[2];

          final lower = toKana(romaji);
          final upper = toKana(romaji.toUpperCase());
          test('${romaji}', () => expect(lower, equals(hiragana)));
          test(
              '${romaji.toUpperCase()}', () => expect(upper, equals(katakana)));
        });
      });

      group('toHiragana()', () {
        ROMA_TO_HIRA_KATA.forEach((item) {
          final romaji = item[0];
          final hiragana = item[1];
          final lower = toHiragana(romaji);
          final upper = toHiragana(romaji.toUpperCase());
          test('${romaji}', () => expect(lower, equals(hiragana)));
          test(
              '${romaji.toUpperCase()}', () => expect(upper, equals(hiragana)));
        });
      });

      group('toKatakana()', () {
        ROMA_TO_HIRA_KATA.forEach((item) {
          final romaji = item[0];
          final katakana = item[2];
          final lower = toKatakana(romaji);
          final upper = toKatakana(romaji.toUpperCase());

          test('${romaji}', () => expect(lower, equals(katakana)));
          test(
              '${romaji.toUpperCase()}', () => expect(upper, equals(katakana)));
        });
      });

      group('Hiragana input toRomaji()', () {
        HIRA_KATA_TO_ROMA.forEach((item) {
          final hiragana = item[0];
          final romaji = item[2];

          if (!kana.isEmpty(hiragana)) {
            final result = toRomaji(hiragana);
            test('${hiragana}', () => expect(result, equals(romaji)));
          }
        });
      });
      group('Katakana input toRomaji()', () {
        HIRA_KATA_TO_ROMA.forEach((item) {
          final katakana = item[1];
          final romaji = item[2];
          if (!kana.isEmpty(katakana)) {
            final result = toRomaji(katakana);
            test('${katakana}', () => expect(result, equals(romaji)));
          }
        });
      });
    });

    group('Converting kana to kana', () {
      test('k -> h', () => expect(toHiragana('バケル'), equals('ばける')));
      test('h -> k', () => expect(toKatakana('ばける'), equals('バケル')));

      test('It survives only katakana toKatakana',
          () => expect(toKatakana('スタイル'), equals('スタイル')));
      test('It survives only hiragana toHiragana',
          () => expect(toHiragana('すたーいる'), equals('すたーいる')));
      test('Mixed kana converts every char k -> h',
          () => expect(toKatakana('アメリカじん'), equals('アメリカジン')));
      test('Mixed kana converts every char h -> k',
          () => expect(toHiragana('アメリカじん'), equals('あめりかじん')));

      group('long vowels', () {
        test('Converts long vowels correctly from k -> h',
            () => expect(toHiragana('バツゴー'), equals('ばつごう')));
        test('Preserves long dash from h -> k',
            () => expect(toKatakana('ばつゲーム'), equals('バツゲーム')));
        test('Preserves long dash from h -> h',
            () => expect(toHiragana('ばつげーむ'), equals('ばつげーむ')));
        test('Preserves long dash from k -> k',
            () => expect(toKatakana('バツゲーム'), equals('バツゲーム')));
        test('Preserves long dash from mixed -> k',
            () => expect(toKatakana('バツゲーム'), equals('バツゲーム')));
        test('Preserves long dash from mixed -> k',
            () => expect(toKatakana('テスーと'), equals('テスート')));
        test('Preserves long dash from mixed -> h',
            () => expect(toHiragana('てすート'), equals('てすーと')));
        test('Preserves long dash from mixed -> h',
            () => expect(toHiragana('てすー戸'), equals('てすー戸')));
        test('Preserves long dash from mixed -> h',
            () => expect(toHiragana('手巣ート'), equals('手巣ーと')));
        test('Preserves long dash from mixed -> h',
            () => expect(toHiragana('tesート'), equals('てsーと')));
        test('Preserves long dash from mixed -> h',
            () => expect(toHiragana('ートtesu'), equals('ーとてす')));
      });

      group('Mixed syllabaries', () {
        test(
            'It passes non-katakana through when passRomaji is true k -> h',
            () => expect(toHiragana('座禅‘zazen’スタイル', {'passRomaji': true}),
                equals('座禅‘zazen’すたいる')));

        test(
            'It passes non-hiragana through when passRomaji is true h -> k',
            () => expect(toKatakana('座禅‘zazen’すたいる', {'passRomaji': true}),
                equals('座禅‘zazen’スタイル')));

        test('It converts non-katakana when passRomaji is false k -> h',
            () => expect(toHiragana('座禅‘zazen’スタイル'), equals('座禅「ざぜん」すたいる')));

        test('It converts non-hiragana when passRomaji is false h -> k',
            () => expect(toKatakana('座禅‘zazen’すたいる'), equals('座禅「ザゼン」スタイル')));
      });
    });

    group('Case sensitivity', () {
      test("cAse DoEsn'T MatTER for toHiragana()",
          () => expect(toHiragana('aiueo'), equals(toHiragana('AIUEO'))));
      test("cAse DoEsn'T MatTER for toKatakana()",
          () => expect(toKatakana('aiueo'), equals(toKatakana('AIUEO'))));
      test('Case DOES matter for toKana()',
          () => expect(toKana('aiueo'), isNot(toKana('AIUEO'))));
    });

    group('N edge cases', () {
      test('Solo N', () => expect(toKana('n'), equals('ん')));
      test('double N', () => expect(toKana('onn'), equals('おんん')));
      test('N followed by N* syllable',
          () => expect(toKana('onna'), equals('おんな')));
      test('Triple N', () => expect(toKana('nnn'), equals('んんん')));
      test('Triple N followed by N* syllable',
          () => expect(toKana('onnna'), equals('おんんな')));
      test('Quadruple N', () => expect(toKana('nnnn'), equals('んんんん')));
      test('nya -> にゃ', () => expect(toKana('nyan'), equals('にゃん')));
      test('nnya -> んにゃ', () => expect(toKana('nnyann'), equals('んにゃんん')));
      test('nnnya -> んにゃ', () => expect(toKana('nnnyannn'), equals('んんにゃんんん')));
      test("n'ya -> んや", () => expect(toKana("n'ya"), equals('んや')));
      test("kin'ya -> きんや", () => expect(toKana("kin'ya"), equals('きんや')));
      test("shin'ya -> しんや", () => expect(toKana("shin'ya"), equals('しんや')));
      test('kinyou -> きにょう', () => expect(toKana('kinyou'), equals('きにょう')));
      test("kin'you -> きんよう", () => expect(toKana("kin'you"), equals('きんよう')));
      test("kin'yu -> きんゆ", () => expect(toKana("kin'yu"), equals('きんゆ')));
      test('Properly add space after "n[space]"',
          () => expect(toKana('ichiban warui'), equals('いちばん わるい')));
    });

    group('Bogus 4 character sequences', () {
      test('Non bogus sequences work',
          () => expect(toKana('chya'), equals('ちゃ')));
      test('Bogus sequences do not work',
          () => expect(toKana('chyx'), equals('chyx')));
      test('Bogus sequences do not work',
          () => expect(toKana('shyp'), equals('shyp')));
      test('Bogus sequences do not work',
          () => expect(toKana('ltsb'), equals('ltsb')));
    });
  });
}
