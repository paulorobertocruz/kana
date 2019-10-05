import 'package:kana/src/utils/is_empty.dart';

bool isCharInRange(String char, int start, int end) {
  if (isEmpty(char)) return false;
  final int code = char.codeUnitAt(0);
  return start <= code && code <= end;
}