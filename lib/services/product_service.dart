import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:reuse/controllers/auth_controller.dart';
import 'package:reuse/models/product_model.dart';
import 'package:reuse/models/user_model.dart';
import 'package:reuse/services/auth_service.dart';
import 'package:get/get.dart';

class ProductService {
  // Register new user
  static Future<List<ProductModel>> getAllProducts() async {
    const baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/product"; // sesuaikan IP jika perlu
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

      // print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body)['data'];
        // print(body);
        return body.map((json) => ProductModel.fromJson(json)).toList();
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Get.offAllNamed('/login');
        return [];
      } else {
        final body = jsonDecode(response.body);
        // print(body);
        throw Exception(body['message'] ?? 'Failed fetch product');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed fetch product: ${e.toString()}');
    }
  }

  static Future<List<ProductModel>> getAllMyProducts() async {
    const baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/product/my-products"; // sesuaikan IP jika perlu
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
        return body.map((json) => ProductModel.fromJson(json)).toList();
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Get.offAllNamed('/login');
        return [];
      } else {
        final body = jsonDecode(response.body);
        // print(body);
        throw Exception(body['message'] ?? 'Failed fetch product');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed fetch product: ${e.toString()}');
    }
  }

  static Future<void> createProduct({
    required String name,
    required int price,
    required String description,
    required double plasticSaved,
    required double carbonSaved,
    required double wasteSaved,
    required XFile imageFile,
  }) async {
    const baseUrl = "https://api.reuse.ngodingbareng.my.id/api/product";
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      throw Exception('Token not found. User not logged in.');
    }
    final token = user.accessToken;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl))
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['name'] = name
        ..fields['price'] = price.toString()
        ..fields['description'] = description
        ..fields['plastic_saved'] = plasticSaved.toString()
        ..fields['carbon_saved'] = carbonSaved.toString()
        ..fields['waste_saved'] = wasteSaved.toString()
        ..files.add(await http.MultipartFile.fromPath(
          'image_url',
          imageFile.path,
        ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Get.offAllNamed('/login');
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to create product');
      }
    } catch (e) {
      throw Exception('Failed to create product: ${e.toString()}');
    }
  }

  static Future<void> updateProduct({
    required String id,
    required String name,
    required int price,
    required String description,
    required double plasticSaved,
    required double carbonSaved,
    required double wasteSaved,
    required XFile? imageFile,
  }) async {
    var baseUrl = 'https://api.reuse.ngodingbareng.my.id/api/product/$id';
    // const baseUrl = 'https://api.reuse.ngodingbareng.my.id/api/product/$id';
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      throw Exception('Token not found. User not logged in.');
    }
    final token = user.accessToken;

    try {
      var request = http.MultipartRequest('PUT', Uri.parse(baseUrl))
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['name'] = name
        ..fields['price'] = price.toString()
        ..fields['description'] = description
        ..fields['plastic_saved'] = plasticSaved.toString()
        ..fields['carbon_saved'] = carbonSaved.toString()
        ..fields['waste_saved'] = wasteSaved.toString();
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image_url',
          imageFile.path,
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Get.offAllNamed('/login');
      } else {
        final error = jsonDecode(response.body);
        print(error);
        print("test");
        throw Exception(error['message'] ?? 'Failed to update product');
      }
    } catch (e) {
      print(e);
      print("test");

      throw Exception('Failed to update product: ${e.toString()}');
    }
  }

  static Future<void> editProduct({
    required String id,
    required String name,
    required int price,
    required String description,
    required int plasticSaved,
    required int carbonSaved,
    required String wasteSaved,
    required XFile imageFile,
  }) async {
    var baseUrl = "https://api.reuse.ngodingbareng.my.id/api/product/${id}";
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      throw Exception('Token not found. User not logged in.');
    }
    final token = user.accessToken;

    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseUrl))
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['name'] = name
        ..fields['price'] = price.toString()
        ..fields['description'] = description
        ..fields['plastic_saved'] = plasticSaved.toString()
        ..fields['carbon_saved'] = carbonSaved.toString()
        ..fields['waste_saved'] = wasteSaved
        ..files.add(await http.MultipartFile.fromPath(
          'image_url',
          imageFile.path,
        ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Get.offAllNamed('/login');
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to create product');
      }
    } catch (e) {
      throw Exception('Failed to create product: ${e.toString()}');
    }
  }

  static Future<ProductModel?> getProduct({required String id}) async {
    final baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/product/$id"; // sesuaikan IP jika perlu
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
        return ProductModel.fromJson(jsonDecode(response.body)['data']);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        Get.offAllNamed('/login');
        return null;
      } else {
        final body = jsonDecode(response.body);
        // print(body);
        throw Exception(body['message'] ?? 'Failed fetch product');
      }
    } catch (e) {
      // print(e);
      throw Exception('Failed fetch product: ${e.toString()}');
    }
  }

  static Future<void> deleteProduct({required String id}) async {
    final baseUrl =
        "https://api.reuse.ngodingbareng.my.id/api/product/$id"; // sesuaikan IP jika perlu
    final user = await AuthService.getUserFromPrefs();
    if (user == null) {
      throw Exception('Token not found. User not logged in.');
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
        throw Exception(body['message'] ?? 'Failed fetch product');
      }
    } catch (e) {
      // print(e);
      throw Exception('Failed fetch product: ${e.toString()}');
    }
  }
}
