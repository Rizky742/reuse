import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:reuse/controllers/auth_controller.dart';
import 'package:reuse/models/exchange_model.dart';
import 'package:reuse/models/product_model.dart';
import 'package:reuse/models/user_model.dart';
import 'package:reuse/services/auth_service.dart';

class ExchangeService {
  // Register new user

  static Future<void> createOffer({
    required String receiverId,
    required String receiverProductId,
    required String requesterProductId,
    required String notes,
  }) async {
    const baseUrl = "https://api.reuse.ngodingbareng.my.id/api/exchange/create-offer";
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      throw Exception('Token not found. User not logged in.');
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
          "receiver_id": receiverId,
          "receiver_product_id": receiverProductId,
          "requester_product_id": requesterProductId,
          "notes": notes
        }),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to create Offers');
      }
    } catch (e) {
      throw Exception('Failed to create Offers: ${e.toString()}');
    }
  }

  static Future<List<ExchangeModel>> getOffersMade() async {
    const baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/exchange/get-offer-made"; // sesuaikan IP jika perlu
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      throw Exception('Token not found. User not logged in.');
    }
    final token = user.accessToken;
    // print("token" + token);
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body)['data'];
        // print(body);
        return body.map((json) => ExchangeModel.fromJson(json)).toList();
      } else {
        final body = jsonDecode(response.body);
        // print(body);
        throw Exception(body['message'] ?? 'Failed fetch offer made');
      }
    } catch (e) {
      // print(e);
      throw Exception('Failed fetch product: ${e.toString()}');
    }
  }

  static Future<List<ExchangeModel>> getOffersReceived() async {
    const baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/exchange/get-offer-received"; // sesuaikan IP jika perlu
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      throw Exception('Token not found. User not logged in.');
    }
    final token = user.accessToken;
    // print("token" + token);
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body)['data'];
        // print(body);
        return body.map((json) => ExchangeModel.fromJson(json)).toList();
      } else {
        final body = jsonDecode(response.body);
        // print(body);
        throw Exception(body['message'] ?? 'Failed fetch offers received');
      }
    } catch (e) {
      // print(e);
      throw Exception('Failed fetch product: ${e.toString()}');
    }
  }

  static Future<List<ExchangeModel>> getCompletedOffer() async {
    const baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/exchange/get-completed-offer"; // sesuaikan IP jika perlu
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      throw Exception('Token not found. User not logged in.');
    }
    final token = user.accessToken;
    // print("token" + token);
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body)['data'];
        // print(body);
        return body.map((json) => ExchangeModel.fromJson(json)).toList();
      } else {
        final body = jsonDecode(response.body);
        // print(body);
        throw Exception(body['message'] ?? 'Failed fetch completed offer');
      }
    } catch (e) {
      // print(e);
      throw Exception('Failed fetch completed offer: ${e.toString()}');
    }
  }

  static Future<void> updateStatusOffer(
      {required String id, required String status, String? metode}) async {
    final baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/exchange/status/$id"; // sesuaikan IP jika perlu
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      throw Exception('Token not found. User not logged in.');
    }
    final token = user.accessToken;
    // print("token" + token);
    try {
      final response = await http.put(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "status": status,
          "metode": metode ?? '',
        }),
      );
      print(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final body = jsonDecode(response.body);
        // print(body);
        throw Exception(body['message'] ?? 'Failed update status offer');
      }
    } catch (e) {
      // print(e);
      throw Exception('Failed update status offer: ${e.toString()}');
    }
  }
}
