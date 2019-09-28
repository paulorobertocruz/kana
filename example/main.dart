import 'package:kana/kana.dart';

void main() {  
  print("Hiragana ${getHiragana("a")} from Romaji a");
  print("Katakana ${getKatakana("a")} from Romaji a");
  print("Romaji ${getRomajiFromHiragana("あ")} from Hiragana あ");
  print("Romaji ${getRomajiFromKatakana("ア")} from Katakana ア");
}
