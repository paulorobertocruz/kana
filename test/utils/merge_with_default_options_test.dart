import 'package:test/test.dart';
import 'package:kana/src/constants.dart' show DEFAULT_OPTIONS;
import 'package:kana/src/utils/merge_with_default_options.dart';

void main() {
  group('mergeWithDefaultOptions', () {
    test('sane defaults', () {
      expect(mergeWithDefaultOptions(), equals(DEFAULT_OPTIONS));
      expect(mergeWithDefaultOptions({}), equals(DEFAULT_OPTIONS));
    });
    test('applies custom options over default options', () {
      expect(
          mergeWithDefaultOptions({
            'useObsoleteKana': true,
            'passRomaji': true,
            'upcaseKatakana': true,
            'ignoreCase': true,
            'IMEMode': true,
            'romanization': 'hepburn',
            'customKanaMapping': {'wa': 'な'},
            'customRomajiMapping': {'な': 'wa'},
          }),
          equals({
            'useObsoleteKana': true,
            'passRomaji': true,
            'upcaseKatakana': true,
            'ignoreCase': true,
            'IMEMode': true,
            'romanization': 'hepburn',
            'customKanaMapping': {'wa': 'な'},
            'customRomajiMapping': {'な': 'wa'},
          }));
    });
  });
}
