import 'package:kana/src/utils/merge_with_default_options.dart';
import 'package:kana/src/utils/katakana_to_hiragana.dart';
import 'package:kana/src/is_katakana.dart';
import 'package:kana/src/utils/kana_to_romaji_map.dart'
    show getKanaToRomajiTree;
import 'package:kana/src/utils/kana_mapping.dart'
    show applyMapping, mergeCustomMapping;

String toRomaji(String input, [options = const {}]) {
  final mergedOptions = mergeWithDefaultOptions(options);
  // just throw away the substring index information and just concatenate all the kana
  return splitIntoRomaji(input, mergedOptions).map((romajiToken) {
    var start = romajiToken[0];
    var end = romajiToken[1];
    var romaji = romajiToken[2];
    final makeUpperCase =
        options["upcaseKatakana"] && isKatakana(input.substring(start, end));
    return makeUpperCase ? romaji.toUpperCase() : romaji;
  }).join('');
}

var customMapping = null;
splitIntoRomaji(input, options) {
  var map = getKanaToRomajiTree(options);

  if (options.customRomajiMapping) {
    if (customMapping == null) {
      customMapping = mergeCustomMapping(map, options.customRomajiMapping);
    }
    map = customMapping;
  }

  return applyMapping(
      katakanaToHiragana(input, toRomaji, true), map, !options.IMEMode);
}
