import 'package:test/test.dart';
import 'package:kana/src/utils/get_chunk.dart';

void main() {
  group('getChunk', () {
    test('sane default', () => expect(getChunk(), equals('')));
    test('passes parameter tests', () {
      expect(getChunk('paulo', 1, 3), equals('au'));
      expect(getChunk('derpalerp', 3, 6), equals('pal'));
      expect(getChunk('derpalerp', 3), equals('palerp'));
      expect(getChunk('derpalerp'), equals('derpalerp'));
      expect(getChunk('de', 0, 1), equals('d'));
      expect(getChunk('', 1, 2), equals(''));
    });
  });
}
