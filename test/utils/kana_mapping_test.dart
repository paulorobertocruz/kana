import 'package:test/test.dart';
import 'package:kana/kana.dart' show toKana, toRomaji;
import 'package:kana/src/utils/kana_mapping/kana_mapping.dart'
    show mergeCustomMapping, createCustomMapping, transform;

void main() {
  group('KanaMapping', () {
    test('safe defaults', () {
      expect(() => createCustomMapping(), returnsNormally);
      expect(() => createCustomMapping({}), returnsNormally);
      expect(() => createCustomMapping(null), returnsNormally);
      expect(() => mergeCustomMapping(), returnsNormally);
      expect(() => mergeCustomMapping({}), returnsNormally);
      expect(() => mergeCustomMapping({}, null), returnsNormally);
      expect(() => mergeCustomMapping(null, null), returnsNormally);
    });
    test('transform', () {
      // transform the tree, so that for example hepburnTree['ゔ']['ぁ'][''] == 'va'
      expect(
          () => transform({
                'ゔ': {
                  'ぁ': ''
                }
              }),
          returnsNormally);
    });
    group('Test custom mappings options', () {
      test('applies customKanaMapping', () {
        expect(
            toKana('wanakana', {
              'customKanaMapping':
                  createCustomMapping({'na': 'に', 'ka': 'Bana'}),
            }),
            equals('わにBanaに'));
      });

      test("can't romanize with an invalid method", () {
        expect(toRomaji('つじぎり', {'romanization': "it's called rōmaji!!!"}),
            equals('つじぎり'));
      });

      test('applies customRomajiMapping', () {
        expect(
            toRomaji('つじぎり', {
              'customRomajiMapping':
                  createCustomMapping({'じ': 'zi', 'つ': 'tu', 'り': 'li'}),
            }),
            equals('tuzigili'));
      });

      test(
          'will accept a plain object and merge it internally via createCustomMapping()',
          () {
        expect(
            toKana('wanakana', {
              'customKanaMapping': {'na': 'に', 'ka': 'Bana'},
            }),
            equals('わにBanaに'));

        expect(
            toRomaji('つじぎり', {
              'customRomajiMapping': {'じ': 'zi', 'つ': 'tu', 'り': 'li'},
            }),
            equals('tuzigili'));
      });
    });
  });
}
