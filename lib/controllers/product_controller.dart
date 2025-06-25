import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reuse/models/product_model.dart';
import 'package:reuse/services/product_service.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  // Reactive state variables
  final Rx<List<ProductModel>> _products = Rx<List<ProductModel>>([]);
  final Rx<List<ProductModel>> _myproducts = Rx<List<ProductModel>>([]);
  final Rx<ProductModel?> _product = Rx<ProductModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Getters
  List<ProductModel> get products => _products.value;
  List<ProductModel> get myProducts => _myproducts.value;
  ProductModel? get product => _product.value;

  @override
  void onInit() {
    super.onInit();
    ever(errorMessage, (msg) {
      if (msg.isNotEmpty) {
        showErrorSnackbar(msg);
      }
    });
  }

  void showErrorSnackbar(String message) {
    if (Get.isSnackbarOpen) return;

    Get.snackbar(
      'Error',
      message,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> getAllProducts() async {
    try {
      isLoading(true);
      errorMessage('');
      final products = await ProductService.getAllProducts();
      _products.value = products;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      _products.value = []; // Clear previous data on error
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAllMyProducts() async {
    try {
      isLoading(true);
      errorMessage('');
      final products = await ProductService.getAllMyProducts();
      _myproducts.value = products;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      _products.value = []; // Clear previous data on error
    } finally {
      isLoading(false);
    }
  }

  Future<void> createProduct({
    required String name,
    required int price,
    required String description,
    required double plasticSaved,
    required double carbonSaved,
    required double wasteSaved,
    required XFile imageFile,
  }) async {
    try {
      isLoading(true);
      errorMessage('');
      final result = await ProductService.createProduct(
        name: name,
        price: price,
        description: description,
        plasticSaved: plasticSaved,
        carbonSaved: carbonSaved,
        wasteSaved: wasteSaved,
        imageFile: imageFile,
      );

      // Optional: Refresh product list after creation
      await getAllMyProducts();
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProduct({
    required String id,
    required String name,
    required int price,
    required String description,
    required double plasticSaved,
    required double carbonSaved,
    required double wasteSaved,
    required XFile? imageFile,
  }) async {
    try {
      isLoading(true);
      errorMessage('');
      await ProductService.updateProduct(
        id: id,
        name: name,
        price: price,
        description: description,
        plasticSaved: plasticSaved,
        carbonSaved: carbonSaved,
        wasteSaved: wasteSaved,
        imageFile: imageFile,
      );

      // Optional: Refresh product list after creation
      await getAllMyProducts();
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getProduct({required String id}) async {
    try {
      isLoading(true);
      errorMessage('');
      final product = await ProductService.getProduct(id: id);
      _product.value = product;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      _product.value = null; // Clear previous data on error
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteProduct({required String id}) async {
    try {
      isLoading(true);
      errorMessage('');
      await ProductService.deleteProduct(id: id);
      await getAllMyProducts();
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      _product.value = null; // Clear previous data on error
    } finally {
      isLoading(false);
    }
  }

  // Clear product details when needed
  void clearProduct() {
    _product.value = null;
  }

  // Clear all products data
  void clearAllProducts() {
    _products.value = [];
  }
}
