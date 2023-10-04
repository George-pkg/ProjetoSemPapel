class SortPhrase {
  final String Name;
  final String Phrase;

  SortPhrase({
    required this.Name,
    required this.Phrase,
  });

  factory SortPhrase.fromMap(Map<String, dynamic> map) {
    return SortPhrase(
      Name: map['id'],
      Phrase: map['advice'],
    );
  }
}
