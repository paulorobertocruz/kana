import 'package:kana/src/data.dart' show ROMAJI_KATAKANA, KATAKANA_ROMAJI;

String getKatakana(String romaji) {
  if (ROMAJI_KATAKANA.containsKey(romaji)) return ROMAJI_KATAKANA[romaji];
  return null;
}

String getRomajiFromKatakana(String hiragana) {
  if (KATAKANA_ROMAJI.containsKey(hiragana)) return KATAKANA_ROMAJI[hiragana];
  return null;
}
