class ImpactModel {
  final String id;
  final String userId;
  final double wasteSaved;
  final double plasticSaved;
  final double carbonSaved;

  ImpactModel({
    required this.id,
    required this.userId,
    required this.wasteSaved,
    required this.plasticSaved,
    required this.carbonSaved,
  });

  factory ImpactModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      try {
        return double.parse(value.toString());
      } catch (_) {
        return 0.0;
      }
    }

    double roundTwo(double value) =>
        double.parse(value.toStringAsFixed(3)); // Maks 2 angka di belakang koma

    return ImpactModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      wasteSaved: roundTwo(parseDouble(json['waste_saved'])),
      plasticSaved: roundTwo(parseDouble(json['plastic_saved'])),
      carbonSaved: roundTwo(parseDouble(json['carbon_saved'])),
    );
  }
}
