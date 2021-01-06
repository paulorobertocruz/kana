import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_in_range.dart';
import 'package:kana/src/constants.dart' show HIRAGANA_END, HIRAGANA_START;

void main() {
  group('isCharInRange', () {
    test('sane default', () => expect(isCharInRange(), equals(false)));
    test('passes parameter tests', () {
      expect(isCharInRange('は', HIRAGANA_START, HIRAGANA_END), equals(true));
      expect(isCharInRange('d', HIRAGANA_START, HIRAGANA_END), equals(false));
    });
  });
}
