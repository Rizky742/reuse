import 'package:get/get.dart';
import 'package:reuse/controllers/cart_controller.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/models/cart_model.dart';
import 'package:reuse/models/transaction_model.dart';
import 'package:reuse/services/transaction_service.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();
  final RxList<TransactionModel> _historyTransaction = <TransactionModel>[].obs;
  final RxBool isLoading = false.obs;
  List<TransactionModel> get historyTransaction => _historyTransaction.value;
  Future<bool> createTransaction({required List<CartModel> cart}) async {
    try {
      final cartController = Get.find<CartController>();
      final productController = Get.find<ProductController>();
      isLoading(true);
      await TransactionService.createTransaction(cartItems: cart);
      await cartController.getCart();
      await productController.getAllProducts();
      return true;
    } catch (e) {
      Get.snackbar(
        'Pembayaran Berhasil',
        e.toString().replaceAll('Exception: ', ''), // agar pesan lebih bersih
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 3),
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getHistory() async {
    try {
      isLoading(true);
      final result = await TransactionService.getHistory();
      // await Future.delayed(const Duration(seconds: 4));
      _historyTransaction.value = result;
      isLoading(false);
    } catch (e) {
      Get.snackbar(
        'Fetch History Failed',
        e.toString().replaceAll('Exception: ', ''), // agar pesan lebih bersih
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
