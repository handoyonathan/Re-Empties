extension NullableStringExtension on String? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
  bool get isNullOrEmpty => (this ?? '').isEmpty;

  String get initial {
    if (isNullOrEmpty) return '';
    return this!.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join();
  }
}