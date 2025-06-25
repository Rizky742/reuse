import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reuse/models/impact_model.dart';
import 'package:reuse/services/auth_service.dart';
import 'package:get/get.dart';

class ImpactService {
  static Future<ImpactModel?> getMyImpact() async {
    const baseUrl = "https://api.reuse.ngodingbareng.my.id/api/impact";
    final user = await AuthService.getUserFromPrefs();

    if (user == null) {
      Get.offAllNamed('/login');
      return null;
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
        final decoded = jsonDecode(response.body);
        final data = decoded['data'];
        if (data == null) return null;
        return ImpactModel.fromJson(data);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Get.offAllNamed('/login');
        return null;
      } else {
        final body = jsonDecode(response.body);
        throw Exception(body['message'] ?? 'Failed fetch impact');
      }
    } catch (e) {
      throw Exception('Failed to fetch impact: ${e.toString()}');
    }
  }
}
