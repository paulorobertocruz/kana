import 'package:kana/src/data.dart' show ROMAJI_HIRAGANA, HIRAGANA_ROMAJI;

String getHiragana(String romaji) {
  if (ROMAJI_HIRAGANA.containsKey(romaji)) return ROMAJI_HIRAGANA[romaji];
}

String getRomajiFromHiragana(String hiragana) {
  if (HIRAGANA_ROMAJI.containsKey(hiragana)) return HIRAGANA_ROMAJI[hiragana];
}
