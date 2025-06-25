import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuse/models/cart_model.dart';
import 'package:reuse/services/cart_service.dart';
import 'package:reuse/view/cart_page.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();
  final Rx<List<CartModel>> _cart = Rx<List<CartModel>>([]);
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;
  List<CartModel> get cart => _cart.value;

  Future<void> getCart() async {
    try {
      isLoading(true);
      final result = await CartService.getCart();
      // await Future.delayed(const Duration(seconds: 4));
      _cart.value = result;
      isLoading(false);
    } catch (e) {
      Get.snackbar(
        'Fetch Cart Failed',
        e.toString().replaceAll('Exception: ', ''), // agar pesan lebih bersih
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> addCart({
    required String productId,
    required int amount,
  }) async {
    try {
      isLoading(true);
      await CartService.addCart(
        amount: amount,
        productId: productId,
      );
      await getCart();
      Get.to(() => const CartPage());
    } catch (e) {
      Get.snackbar(
        'Add Cart Failed',
        e.toString().replaceAll('Exception: ', ''), // agar pesan lebih bersih
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateCart({
    required String id,
    required int amount,
  }) async {
    try {
      isUpdating(true);
      await CartService.updateCart(
        id: id,
        amount: amount,
      );
      await getCart();
    } catch (e) {
      Get.snackbar(
        'Update Cart Failed',
        e.toString().replaceAll('Exception: ', ''), // agar pesan lebih bersih
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isUpdating(false);
    }
  }

  Future<void> deleteCart({
    required String id,
  }) async {
    try {
      isUpdating(true);
      await CartService.deleteCart(id: id);
      await getCart();

      // ✅ Tampilkan snackbar berhasil
      Get.snackbar(
        'Berhasil',
        'Item berhasil dihapus dari keranjang.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Delete Cart Failed',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isUpdating(false);
    }
  }
}
