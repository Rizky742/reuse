import 'package:reuse/models/transaction_detail_model.dart';

class TransactionModel {
  final String id;
  final String transactionDate;
  final int totalPrice;
  final List<TransactionDetail> details;

  TransactionModel({
    required this.id,
    required this.transactionDate,
    required this.totalPrice,
    required this.details,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      transactionDate: json['transaction_date'],
      totalPrice: json['total_price'],
      details: (json['details'] as List)
          .map((item) => TransactionDetail.fromJson(item))
          .toList(),
    );
  }
}
