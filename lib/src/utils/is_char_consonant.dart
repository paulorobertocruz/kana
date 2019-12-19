import 'package:kana/src/utils/is_empty.dart';

bool isCharConsonant(String char, [bool includeY = true]) {
  if (isEmpty(char)) return false;
  if (char.length > 1) return false;
  final regexp = RegExp(
      includeY ? r"[bcdfghjklmnpqrstvwxyz]" : r"[bcdfghjklmnpqrstvwxz]");
  return regexp.hasMatch(char[0].toLowerCase());
}
