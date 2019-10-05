import 'package:kana/src/constants.dart' show TO_KANA_METHODS;
import 'package:kana/src/utils/merge_with_default_options.dart';
import 'package:kana/src/utils/romaji_to_kana_map.dart'
    show getRomajiToKanaTree, IME_MODE_MAP, USE_OBSOLETE_KANA_MAP;
import 'package:kana/src/utils/kana_mapping.dart'
    show applyMapping, mergeCustomMapping;
import 'package:kana/src/utils/is_char_upper_case.dart';
import 'package:kana/src/utils/hiragaka_to_katakana.dart';

String toKana(String input, [options = const {}, map]) {
  var config;
  if (map == null) {
    config = mergeWithDefaultOptions(options);
    map = createRomajiToKanaMap(config);
  } else {
    config = options;
  }

  // throw away the substring index information and just concatenate all the kana
  return splitIntoConvertedKana(input, config, map).map((kanaToken) {
    final start = kanaToken[0];
    final end = kanaToken[1];
    final kana = kanaToken[2];
    if (kana == null) {
      // haven't converted the end of the string, since we are in IME mode
      return input.substring(start);
    }
    final enforceHiragana = config.IMEMode == TO_KANA_METHODS["HIRAGANA"];
    final enforceKatakana = config.IMEMode == TO_KANA_METHODS["KATAKANA"] ||
        input.substring(start, end).split('').every(isCharUpperCase);

    return enforceHiragana || !enforceKatakana
        ? kana
        : hiraganaToKatakana(kana);
  }).join('');
}

/**
 *
 * @private
 * @param {String} [input=''] input text
 * @param {Object} [options={}] toKana options
 * @returns {Array[]} [[start, end, token]]
 * @example
 * splitIntoConvertedKana('buttsuuji')
 * // => [[0, 2, 'ぶ'], [2, 6, 'っつ'], [6, 7, 'う'], [7, 9, 'じ']]
 */
List splitIntoConvertedKana(String input, [Map options = const {}, map]) {
  if (map == null) {
    map = createRomajiToKanaMap(options);
  }
  final IMEMode = options.containsKey("IMEMode") && !options["IMEMode"];
  return applyMapping(input.toLowerCase(), map, IMEMode);
}

var customMapping = null;
Map createRomajiToKanaMap([options = const {}]) {
  var map = getRomajiToKanaTree();

  map = options.IMEMode ? IME_MODE_MAP(map) : map;
  map = options.useObsoleteKana ? USE_OBSOLETE_KANA_MAP(map) : map;

  if (options.customKanaMapping) {
    if (customMapping == null) {
      customMapping = mergeCustomMapping(map, options.customKanaMapping);
    }
    map = customMapping;
  }

  return map;
}
