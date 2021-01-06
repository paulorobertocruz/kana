import 'dart:math';

int getChunkSize([int max = 0, int remaining = 0]) {
  return min(max, remaining);
}
