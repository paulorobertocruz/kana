import 'dart:core';
import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_long_dash.dart' as kana;

void main(){
  test("isCharLongDash returns false when empty 1", (){
    expect(kana.isCharLongDash(""), isFalse);
  });
  test("isCharLongDash returns false when empty 2", (){
    expect(kana.isCharLongDash(" "), isFalse);
  });
  test("isCharLongDash returns false when .", (){
    expect(kana.isCharLongDash("."), isFalse);
  });
  test("isCharLongDash returns true when ー", (){
    expect(kana.isCharLongDash("ー"), isTrue);
  });  
}