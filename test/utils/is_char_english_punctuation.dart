import 'dart:core';
import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_english_punctuation.dart' as kana;

void main(){
  test("isCharEnglishPunctuation returns false when empty 1", (){
    expect(kana.isCharEnglishPunctuation(""), isFalse);
  });
  test("isCharEnglishPunctuation returns false when empty 2", (){
    expect(kana.isCharEnglishPunctuation(" "), isFalse);
  });
  test("isCharEnglishPunctuation returns true when .", (){
    expect(kana.isCharEnglishPunctuation("."), isTrue);
  });
  test("isCharEnglishPunctuation returns false when %", (){
    expect(kana.isCharEnglishPunctuation("%"), isTrue);
  });
  test("isCharEnglishPunctuation returns false when '", (){
    expect(kana.isCharEnglishPunctuation("'"), isTrue);
  });
  test("isCharEnglishPunctuation returns false when ~", (){
    expect(kana.isCharEnglishPunctuation("~"), isTrue);
  });
  //'!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
}