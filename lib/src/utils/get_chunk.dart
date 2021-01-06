String getChunk([String text = '', int start = 0, int end]) {
  try {
    return text.substring(start, end);
  } on RangeError catch (e) {
    return '';
  }
}
