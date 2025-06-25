import 'package:reuse/models/review_model.dart';
import 'package:reuse/models/user_model.dart';

class ProductModel {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final UserModel user;
  final String wasteSaved;
  final String plasticSaved;
  final String carbonSaved;
  final String description;
  final String averageRating;
  final List<ReviewModel> review;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.user,
    required this.wasteSaved,
    required this.carbonSaved,
    required this.description,
    required this.plasticSaved,
    required this.averageRating,
    required this.review,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      carbonSaved: json['carbon_saved']?.toString() ?? '0',
      plasticSaved: json['plastic_saved']?.toString() ?? '0',
      wasteSaved: json['waste_saved']?.toString() ?? '0',
      description: json['description'] ?? "",
      averageRating: json['average_rating']?.toString() ?? "0.00",
      user: UserModel.fromJson(json['users'] ?? {}),
      review: (json['Review'] as List<dynamic>? ?? [])
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

