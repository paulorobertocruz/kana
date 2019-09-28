import 'package:kana/kana.dart';

void main() {
  final r = "shi";
  final h = "ゆ";
  final k = "ア";
  print("Hiragana ${getHiragana(r)} from Romaji $r");
  print("Katakana ${getKatakana(r)} from Romaji $r");
  print("Romaji ${getRomajiFromHiragana(h)} from Hiragana $h");
  print("Romaji ${getRomajiFromKatakana(k)} from Katakana $k");
}
