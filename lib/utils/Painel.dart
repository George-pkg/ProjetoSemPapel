class Painel {
  int id;
  String paste;
  String description;
  bool isExpanded;

  Painel({
    required this.id,
    required this.paste,
    required this.description,
    this.isExpanded = false,
  });

  static List<Painel> gerateItems(int numberOfItems) {
    return List<Painel>.generate(numberOfItems, (int index) {
      return Painel(
        id: index + 1,
        paste: 'Pasta ${index + 1}',
        description: 'conteudo da pasta ${index + 1}',
      );
    });
  }
}