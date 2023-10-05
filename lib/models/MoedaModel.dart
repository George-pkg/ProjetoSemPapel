class MoedaModel {
  final String Name;
  final double Real;
  final double Dolar;
  final double Euro;
  final double Biticoin;

  MoedaModel({
    required this.Name,
    required this.Real,
    required this.Dolar,
    required this.Euro,
    required this.Biticoin,
  });

  factory MoedaModel.fromMap(Map<String, dynamic> map) {
    return MoedaModel(
      Name: map['name'],
      Real: map[''],
      Dolar: map[''],
      Euro: map[''],
      Biticoin: map[''],
    );
  }
}
