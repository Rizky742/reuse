import 'package:reuse/models/product_model.dart';
import 'package:reuse/models/user_model.dart';

class ReviewModel {
  final String id;
  final String name;
  final int rating;
  final String comment;
  final UserModel user;



  ReviewModel({
    required this.id,
    required this.name,
    required this.user,
    required this.rating,
    required this.comment,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
    
    );
  }
}
