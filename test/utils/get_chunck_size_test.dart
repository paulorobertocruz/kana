import 'package:test/test.dart';
import 'package:kana/src/utils/get_chunk_size.dart';

void main() {
  group('getChunkSize', () {
    test('sane default', () => expect(getChunkSize(), equals(0)));
    test('passes parameter tests', () {
      expect(getChunkSize(4, 2), equals(2));
      expect(getChunkSize(2, 2), equals(2));
      expect(getChunkSize(2, 4), equals(2));
      expect(getChunkSize(0, 0), equals(0));
      expect(getChunkSize(3, -1), equals(-1));
    });
  });
}
