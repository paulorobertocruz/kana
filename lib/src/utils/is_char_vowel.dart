import 'package:kana/src/utils/is_empty.dart';

bool isCharVowel([String char, bool includeY = true]) {
  if (isEmpty(char)) return false;
  final String regString = includeY ? r"^[aeiouy]$" : r"^[aeiou]$";
  final regexp = RegExp(regString);
  return regexp.hasMatch(char[0]);
}
