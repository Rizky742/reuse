import 'dart:convert';

import 'package:reuse/models/review_model.dart';
import 'package:reuse/models/reviews_model.dart';
import 'package:reuse/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  static Future<void> addReview({
    required List<ReviewsModel> reviews,
  }) async {
    const baseUrl = "https://api.reuse.ngodingbareng.my.id/api/review/";
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
          "reviews": reviews
              .map((item) => {
                    "rating": item.rating,
                    "comment": item.comment,
                    "productId": item.productId
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
        throw Exception(error['message'] ?? 'Failed to add review');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to add review: ${e.toString()}');
    }
  }
}
