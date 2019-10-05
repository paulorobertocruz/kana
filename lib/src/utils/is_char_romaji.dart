import 'package:kana/src/utils/is_empty.dart';
import 'package:kana/src/utils/is_char_in_range.dart';
import 'package:kana/src/constants.dart' show ROMAJI_RANGES;

bool isCharRomaji(String char){
  if(isEmpty(char)) return false;
  return ROMAJI_RANGES.any((test)=>isCharInRange(char, test[0], test[1]));
}