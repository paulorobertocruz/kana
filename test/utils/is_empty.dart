import 'package:test/test.dart';
import 'package:kana/src/utils/is_empty.dart' as kana;

void main(){
  test("is_empty returns true when empty 1", (){
    expect(kana.isEmpty(""), isTrue);
  });

  test("is_empty returns true when empty 2", (){
    expect(kana.isEmpty(" "), isTrue);
  });

  test("is_empty returns true when null", (){
    expect(kana.isEmpty(null), isTrue);
  });

  test("is_empty returns false when not empty", (){
    expect(kana.isEmpty("j"), isFalse);
  });
}