import 'package:kana/src/utils/merge_with_default_options.dart'
    show mergeWithDefaultOptions;
import 'package:kana/src/utils/katakana_to_hiragana.dart'
    show katakanaToHiragana;
import 'package:kana/src/utils/is_char_english_punctuation.dart'
    show isCharEnglishPunctuation;
import 'package:kana/src/is_romaji.dart' show isRomaji;
import 'package:kana/src/is_mixed.dart' show isMixed;
import 'package:kana/src/to_kana.dart' show toKana;
import 'package:kana/src/to_romaji.dart' show toRomaji;

/**
 * Convert input to [Hiragana](https://en.wikipedia.org/wiki/Hiragana)
 * @param  {String} [input=''] text
 * @param  {DefaultOptions} [options=defaultOptions]
 * @return {String} converted text
 * @example
 * toHiragana('toukyou, オオサカ')
 * // => 'とうきょう、　おおさか'
 * toHiragana('only カナ', { passRomaji: true })
 * // => 'only かな'
 * toHiragana('wi')
 * // => 'うぃ'
 * toHiragana('wi', { useObsoleteKana: true })
 * // => 'ゐ'
 */
String toHiragana(input, [options = const {}]) {
  final config = mergeWithDefaultOptions(options);
  if (config.containsKey("passRomaji") && config["passRomaji"]) {
    return katakanaToHiragana(input, toRomaji);
  }

  if (isMixed(input, {"passKanji": true})) {
    final convertedKatakana = katakanaToHiragana(input, toRomaji);
    return toKana(convertedKatakana.toLowerCase(), config);
  }

  if (isRomaji(input) || isCharEnglishPunctuation(input)) {
    return toKana(input.toLowerCase(), config);
  }

  return katakanaToHiragana(input, toRomaji);
}
