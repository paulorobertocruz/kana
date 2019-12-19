import 'package:test/test.dart';
import 'package:kana/src/utils/is_char_hiragana.dart' as kana;

void main(){
  test("isCharHiragana returns false when empty 1", (){
    expect(kana.isCharHiragana(""), isFalse);
  });

  test("isCharHiragana returns false when empty 2", (){
    expect(kana.isCharHiragana(" "), isFalse);
  });

  test("isCharHiragana returns false when ア", (){
    expect(kana.isCharHiragana("ア"), isFalse);
  });

  test("isCharHiragana returns false when a", (){
    expect(kana.isCharHiragana("a"), isFalse);
  });

  test("isCharHiragana returns true when ゆ", (){
    expect(kana.isCharHiragana("ゆ"), isTrue);
  });
}