import 'dart:core';
import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_consonant.dart' as kana;

void main(){
  test("isCharConsonant returns false when empty 1", (){
    expect(kana.isCharConsonant(""), isFalse);
  });

  test("isCharConsonant returns false when empty 2", (){
    expect(kana.isCharConsonant(" "), isFalse);
  });

  test("isCharConsonant returns true when null", (){
    expect(kana.isCharConsonant(null), isFalse);
  });

  test("isCharConsonant returns true when j", (){
    expect(kana.isCharConsonant("j"), isTrue);
  });

  test("isCharConsonant returns true when b", (){
    expect(kana.isCharConsonant("b"), isTrue);
  });

  test("isCharConsonant returns true when c", (){
    expect(kana.isCharConsonant("c"), isTrue);
  });

  test("isCharConsonant returns true when C", (){
    expect(kana.isCharConsonant("C"), isTrue);
  });

  test("isCharConsonant throws when aa", (){
    expect(kana.isCharConsonant("aa"), isFalse);
  });

  test("isCharConsonant throws when aa", (){
    expect(kana.isCharConsonant("ab"), isFalse);
  });

  test("isCharConsonant throws when aa", (){
    expect(kana.isCharConsonant("bb"), isFalse);
  });
}