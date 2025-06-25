import 'dart:convert';

import 'package:reuse/models/cart_model.dart';
import 'package:reuse/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CartService {
  static Future<void> addCart({
    required String productId,
    required int amount,
  }) async {
    const baseUrl = "https://api.reuse.ngodingbareng.my.id/api/cart/";
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
          "productId": productId,
          "amount": amount,
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to Add to Cart');
      }
    } catch (e) {
      throw Exception('Failed to Add to Cart: ${e.toString()}');
    }
  }

  static Future<void> updateCart({
    required String id,
    required int amount,
  }) async {
    var baseUrl = "https://api.reuse.ngodingbareng.my.id/api/cart/$id";
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      Get.offAllNamed('/login');
      return;
    }
    final token = user.accessToken;

    try {
      final response = await http.put(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "amount": amount,
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to change cart amount');
      }
    } catch (e) {
      throw Exception('Failed to change cart amount: ${e.toString()}');
    }
  }

  static Future<List<CartModel>> getCart() async {
  const baseUrl = "https://api.reuse.ngodingbareng.my.id/api/cart";
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

      return List<CartModel>.from(
        data.map((json) => CartModel.fromJson(json)),
      );
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      Get.offAllNamed('/login');
      throw Exception('Unauthorized access');
    } else {
      final body = jsonDecode(response.body);
      throw Exception(body['message'] ?? 'Failed to fetch cart');
    }
  } catch (e) {
    throw Exception('Failed to fetch cart: ${e.toString()}');
  }
}

  static Future<void> deleteCart({required String id}) async {
    final baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/cart/$id"; // sesuaikan IP jika perlu
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      Get.offAllNamed('/login');
      return;
    }
    final token = user.accessToken;
    // print("token" + token);
    try {
      final response = await http.delete(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Get.offAllNamed('/login');
      } else {
        final body = jsonDecode(response.body);
        // print(body);
        throw Exception(body['message'] ?? 'Failed delete cart');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed delete cart: ${e.toString()}');
    }
  }
}
