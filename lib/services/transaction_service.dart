import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:reuse/models/cart_model.dart';
import 'package:reuse/models/transaction_model.dart';
import 'package:reuse/services/auth_service.dart';

class TransactionService {
  static Future<void> createTransaction({
    required List<CartModel> cartItems,
  }) async {
    const baseUrl = "https://api.reuse.ngodingbareng.my.id/api/transaction/";
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      Get.offAllNamed('/login');
      return;
    }
    final token = user.accessToken;

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "cartItems": cartItems
              .map((item) => {
                    "productId": item.product.id,
                    "quantity": item.amount,
                    "price": item.product.price,
                  })
              .toList(),
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final error = jsonDecode(response.body);
        print(error);
        throw Exception(error['message'] ?? 'Failed to create transaction');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to create transaction: ${e.toString()}');
    }
  }

  static Future<List<TransactionModel>> getHistory() async {
    const baseUrl = "https://api.reuse.ngodingbareng.my.id/api/transaction/history";
    final user = await AuthService.getUserFromPrefs();

    if (user == null) {
      Get.offAllNamed('/login');
      throw Exception('User not logged in');
    }

    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['data'];

        // Kalau data null, kembalikan list kosong
        if (data == null) return [];

        return List<TransactionModel>.from(
          data.map((json) => TransactionModel.fromJson(json)),
        );
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Get.offAllNamed('/login');
        throw Exception('Unauthorized access');
      } else {
        final body = jsonDecode(response.body);
        throw Exception(body['message'] ?? 'Failed to fetch history');
      }
    } catch (e) {
      throw Exception('Failed to fetch history: ${e.toString()}');
    }
  }
}
