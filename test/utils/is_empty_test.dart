import 'package:test/test.dart';
import 'package:kana/src/utils/is_empty.dart' as empty;

void main() {
  group('isEmpty', () {
    test('sane default', () => expect(empty.isEmpty(), equals(true)));
    test('passes parameter tests', () {
      expect(empty.isEmpty(), equals(true));
      expect(empty.isEmpty(22), equals(true));
      expect(empty.isEmpty(null), equals(true));
      expect(empty.isEmpty(''), equals(true));
      expect(empty.isEmpty([]), equals(true));
      expect(empty.isEmpty({}), equals(true));
      expect(empty.isEmpty('nope'), equals(false));
    });
  });
}
