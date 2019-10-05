import 'package:kana/src/is_kanji.dart';
import 'package:kana/src/is_hiragana.dart';
import 'package:kana/src/is_katakana.dart';
import 'package:kana/src/is_romaji.dart';

bool isMixed(String input, [Map options = const {"passKanji": true}]) {
  final chars = input.split('');
  bool hasKanji = false;
  if (options.containsKey("passKanji") && !options["passKanji"]) {
    hasKanji = chars.any(isKanji);
  }
  return (chars.any(isHiragana) || chars.any(isKatakana)) &&
      chars.any(isRomaji) &&
      !hasKanji;
}
