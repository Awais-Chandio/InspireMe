class Quote {
  final String text;
  final String author;
  bool isFavorite;

  Quote({
    required this.text,
    required this.author,
    this.isFavorite = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quote &&
          runtimeType == other.runtimeType &&
          text == other.text;

  @override
  int get hashCode => text.hashCode;
}
