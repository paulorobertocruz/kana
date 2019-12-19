import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_in_range.dart' as kana;

void main(){
  test("isCharInRange returns false when empty 1 a - z", (){
    expect(kana.isCharInRange("", "a".codeUnitAt(0), "z".codeUnitAt(0)), isFalse);
  });

  test("isCharInRange returns false when empty 2 a - z", (){
    expect(kana.isCharInRange(" ", "a".codeUnitAt(0), "z".codeUnitAt(0)), isFalse);
  });

  test("isCharInRange returns false when null a - z", (){
    expect(kana.isCharInRange(null, "a".codeUnitAt(0), "z".codeUnitAt(0)), isFalse);
  });

  test("isCharInRange returns true when b in a - z", (){
    expect(kana.isCharInRange("b", "a".codeUnitAt(0), "z".codeUnitAt(0)), isTrue);
  });
}