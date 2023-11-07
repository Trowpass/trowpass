extension StrictNullExtension on String? {
  String obtainNonNullString() {
    if (this != null && this!.isNotEmpty) {
      return this!;
    } else {
      return '';
    }
  }
}
