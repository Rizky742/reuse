import 'package:get/get.dart';
import 'package:reuse/controllers/cart_controller.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/models/review_model.dart';
import 'package:reuse/models/reviews_model.dart';
import 'package:reuse/services/review_service.dart';

class ReviewController extends GetxController {
  static ReviewController get instance => Get.find();
  final RxBool isLoading = false.obs;

  Future<bool> addReview({required List<ReviewsModel> reviews}) async {
    try {
      // final cartController = Get.find<CartController>();
      // final productController = Get.find<ProductController>();
      isLoading(true);
      await ReviewService.addReview(reviews: reviews);
      // await cartController.getCart();
      // await productController.getAllProducts();
      return true;
    } catch (e) {
      Get.snackbar(
        'Berhasil menambahkan review',
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
}
