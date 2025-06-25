import 'package:reuse/models/product_model.dart';
import 'package:reuse/models/user_model.dart';

class ExchangeModel {
  final String id;
  final String exchangeDate;
  final String? notes;
  final String status;
  final UserModel requester;
  final UserModel receiver;
  final ProductModel requesterProduct;
  final ProductModel receiverProduct;

  // Tambahan properti untuk status completed
  final String? completedDate; // bisa disimpan string, atau DateTime jika mau parsing
  final String? exchangeMethod;
  final String? exchangeLocation;
  final int? rating;

  ExchangeModel({
    required this.id,
    required this.status,
    required this.exchangeDate,
    this.notes,
    required this.requester,
    required this.receiver,
    required this.requesterProduct,
    required this.receiverProduct,
    this.completedDate,
    this.exchangeMethod,
    this.exchangeLocation,
    this.rating,
  });

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    return ExchangeModel(
      id: json['id']?.toString() ?? '',
      exchangeDate: json['exchange_date'] ?? '',
      notes: json['notes'],
      status: json['status'] ?? '',
      requester: UserModel.fromJson(json['requester'] ?? {}),
      receiver: UserModel.fromJson(json['receiver'] ?? {}),
      requesterProduct: ProductModel.fromJson(json['requesterProduct'] ?? {}),
      receiverProduct: ProductModel.fromJson(json['receiverProduct'] ?? {}),
      completedDate: json['completedDate'],          // tambahkan parse jika perlu
      exchangeMethod: json['exchangeMethod'],
      exchangeLocation: json['exchangeLocation'],
      rating: json['rating'] != null ? int.tryParse(json['rating'].toString()) : null,
    );
  }
}
