import 'package:kana/kana.dart';

void main() {
  final r = "shi";
  final h = "ゆ";
  final k = "ア";
  final n = "n";
  final tt = "hohoero zabimaru shoyu no kana";
  print("Hiragana ${toHiragana(r)} from Romaji $r");
  print("Hiragana ${toHiragana(n)} from Romaji $n");
  print("Is hiragana ${isCharHiragana(h)}");
  print("Is hiragana ${isCharHiragana(k)}");
  print("$h hiragana to katakana ${hiraganaToKatakana(h)}");
  print("$h hiragana to katakana and back ${katakanaToHiragana(hiraganaToKatakana(h), toRomaji)}");
  print("${toHiragana(tt)}");  
}
