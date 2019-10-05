import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/constants.dart' show KANA_SLASH_DOT;

bool isCharSlashDot(String char) {
  if (isEmpty(char)) return false;
  return char.codeUnitAt(0) == KANA_SLASH_DOT;
}
