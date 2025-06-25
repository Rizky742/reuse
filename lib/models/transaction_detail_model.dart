import 'package:reuse/models/product_model.dart';

class TransactionDetail {
  final ProductModel product;
  final int quantity;

  TransactionDetail({
    required this.product,
    required this.quantity,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    return TransactionDetail(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
