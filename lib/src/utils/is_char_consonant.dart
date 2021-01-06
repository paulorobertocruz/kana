import 'package:kana/src/utils/is_empty.dart';

bool isCharConsonant([String char, bool includeY = true]) {
  if (isEmpty(char)) return false;
  final String regString =
      includeY ? r"^[bcdfghjklmnpqrstvwxyz]$" : r"^[bcdfghjklmnpqrstvwxz]$";
  final regexp = RegExp(regString);
  return regexp.hasMatch(char[0]);
}
