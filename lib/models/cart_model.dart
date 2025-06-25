import 'package:reuse/models/product_model.dart';
import 'package:reuse/models/user_model.dart';

class CartModel {
  final String id;
  final int amount;
  final ProductModel product;
  final UserModel user;

  CartModel({
    required this.id,
    required this.amount,
    required this.user,
    required this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? '',
      amount: json['amount'] ?? 0,
      user: UserModel.fromJson(json['user'] ?? {}),
      product: ProductModel.fromJson(json['product'] ?? {}),
    );
  }
}
