import 'package:kana/src/utils/kana_mapping/create_custom_mapping.dart';

Map mergeCustomMapping([Map map, dynamic customMapping]) {
  if (customMapping is Function) return customMapping(map);
  if (customMapping is Map) return createCustomMapping(customMapping)(map);
  return map;
}

/*
// allow consumer to pass either function or object as customMapping
export function mergeCustomMapping(map, customMapping) {
  if (!customMapping) {
    return map;
  }
  return typeOf(customMapping) === 'function'
    ? customMapping(map)
    : createCustomMapping(customMapping)(map);
}
*/
