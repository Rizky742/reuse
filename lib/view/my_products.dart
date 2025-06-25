import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/models/product_model.dart';
import 'package:reuse/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/utils/formatPrice.dart';
import 'package:reuse/view/add_product.dart';
import 'package:reuse/view/product_page.dart';

class MyProductsPage extends StatelessWidget {
  MyProductsPage({super.key});

  final ProductController _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Products',
          style: heading2.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Search Bar
            _buildSearchBar(),
            SizedBox(height: 20.h),

            // Product List
            Expanded(
              child: Obx(() {
                if (_productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_productController.myProducts.isEmpty) {
                  return _buildEmptyState();
                }

                return _buildProductList();
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Get.to(() => const AddProductPage())},
        backgroundColor: primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search my products...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory, size: 60.w, color: Colors.grey[400]),
          SizedBox(height: 16.h),
          Text(
            'No Products Yet',
            style: heading3.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap the + button to add your first product',
            style: body2.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.69),
      itemCount: _productController.myProducts.length,
      itemBuilder: (context, index) {
        final product = _productController.myProducts[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () => {
        _productController.getProduct(id: product.id),
        Get.to(() => ProductPage(id: product.id, isMyProduct: true,))
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Container(
                height: 120.h,
                width: double.infinity,
                color: Colors.grey[200],
                child: product.imageUrl.isNotEmpty
                    ? Image.network(
                        "https://api.reuse.ngodingbareng.my.id${product.imageUrl}",
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image),
                      )
                    : const Icon(Icons.image, size: 40),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Product Name
                  Text(
                    product.name,
                    style: body1.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),

                  // Price
                  Text(
                    formatPrice(product.price),
                    style: body2.copyWith(color: primary),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
                    onTap: () => _showProductOptions(product),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Center(
                        child: Text(
                          "Options",
                          style: body2.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductOptions(ProductModel product) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Product'),
              onTap: () {
                Get.back();
                Get.toNamed('/edit-product', arguments: product.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Get.back();
                _confirmDelete(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(ProductModel product) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _productController.deleteProduct(id: product.id);
              Get.back();
              // Call delete method from controller
              Get.snackbar(
                'Deleted',
                'Product has been deleted',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
