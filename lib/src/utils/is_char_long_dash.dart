import 'package:kana/src/constants.dart' show PROLONGED_SOUND_MARK;
import 'package:kana/src/utils/is_empty.dart';

bool isCharLongDash([String char]) {
  if (isEmpty(char)) return false;
  return char.codeUnitAt(0) == PROLONGED_SOUND_MARK;
}
