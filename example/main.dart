import 'package:kana/kana.dart';

void main() {
  final r = "shi";
  final h = "ゆ";
  final k = "ア";
  final tt = "hohoero zabimaru shoyu no kana";
  print("Hiragana ${getHiragana(r)} from Romaji $r");
  print("Katakana ${getKatakana(r)} from Romaji $r");
  print("Romaji ${getRomajiFromHiragana(h)} from Hiragana $h");
  print("Romaji ${getRomajiFromKatakana(k)} from Katakana $k");
  print("Is hiragana ${isCharHiragana(h)}");
  print("Is hiragana ${isCharHiragana(k)}");
  print("$h hiragana to katakana ${hiraganaToKatakana(h)}");
  print("$h hiragana to katakana and back ${katakanaToHiragana(hiraganaToKatakana(h), toRomaji)}");
  print("${toHiragana(tt)}");
}
