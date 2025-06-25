import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reuse/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String userKey = 'user_data';

  // Simpan user ke SharedPreferences
  static Future<void> saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(userKey, userJson);
  }

  static Future<UserModel?> getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(userKey);
    if (userJson == null) return null;
    return UserModel.fromJson(jsonDecode(userJson));
  }

  static Future<void> clearUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }

  // Register new user
  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    required String noHp,
  }) async {
    const baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/auth/register"; // sesuaikan IP jika perlu
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
          "name": name,
          "phone_number": noHp,
        }),
      );

      print(response.body);


      if (response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        final body = jsonDecode(response.body);
        throw Exception(body['message'] ?? 'Password atau Email salah');
      }
    } catch (e) {
      throw Exception('Created account failed: ${e.toString()}');
    }
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    const baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/auth/login"; // sesuaikan IP jika perlu

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(jsonDecode(response.body));
        await saveUserToPrefs(user);
        return user;
      } else {
        final body = jsonDecode(response.body);
        throw Exception(body['message'] ?? 'Password atau Email salah');
      }
    } catch (e) {
      // print(e);
      throw Exception('Login failed: ${e.toString()}');
    }
  }
}
