import 'package:kana/src/utils/is_empty.dart';

bool isCharVowel(String char, bool includeY) {
  if (isEmpty(char)) return false;
  //const regexp = includeY ? /[aeiouy]/ : /[aeiou]/;
  //return char.toLowerCase().charAt(0).search(regexp) !== -1;
}