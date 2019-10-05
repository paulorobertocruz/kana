import 'package:kana/src/constants.dart' show DEFAULT_OPTIONS;

Map mergeWithDefaultOptions([opts = const {}]) {
  return {}..addAll(DEFAULT_OPTIONS)..addAll(opts);
}
    
