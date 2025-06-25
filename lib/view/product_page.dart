import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/cart_controller.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/models/product_model.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/utils/formatPrice.dart';
import 'package:reuse/view/add_product.dart';
import 'package:reuse/view/cart_page.dart';
import 'package:reuse/view/create_exchange_offer_page.dart';
import 'package:reuse/view/home_page.dart';
import 'package:reuse/widgets/star_dynamic.dart';

class ProductPage extends StatefulWidget {
  final String id;
  final bool isMyProduct;

  const ProductPage({super.key, required this.id, required this.isMyProduct});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController _productController = Get.find<ProductController>();
  final CartController _cartController = Get.find<CartController>();
  int? selectedSize;
  Color? selectedColor;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      await _productController.getProduct(id: widget.id);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load product details',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        if (_productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_productController.product == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_productController.errorMessage.value),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: _loadProduct,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return _buildProductDetails();
      }),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        // onPressed: () => Get.to(
        //   () => const HomePage(
        //     initialIndex: 4,
        //   ),
        // ),
        onPressed: () => Get.back(),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/main_logo.svg',
            width: 23.w,
            colorFilter: const ColorFilter.mode(primary, BlendMode.srcIn),
          ),
          SizedBox(width: 5.w),
          Text(
            "Reuse",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProductDetails() {
    final product = _productController.product!;
    final rating = double.tryParse(product.averageRating) ?? 0.0;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(product),
          SizedBox(height: 16.h),
          _buildProductHeader(product, rating),
          SizedBox(height: 16.h),
          _buildProductTabs(product, rating),
          SizedBox(height: 16.h),
          _buildEnvironmentalImpact(product),
          SizedBox(height: 24.h),
          _buildActionButtons(isOwnProduct: widget.isMyProduct),
        ],
      ),
    );
  }

  Widget _buildProductImage(ProductModel product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        width: double.infinity,
        height: 282.h,
        decoration: const BoxDecoration(color: Colors.grey),
        child: (product.imageUrl != null && product.imageUrl.isNotEmpty)
            ? Image.network(
                "https://api.reuse.ngodingbareng.my.id${product.imageUrl}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/shoes.jpg',
                    fit: BoxFit.cover,
                  );
                },
              )
            : Image.asset(
                'assets/shoes.jpg',
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _buildProductHeader(ProductModel product, double rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.name,
                style: heading3.copyWith(color: primary),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
              child: Text(
                "Zero Plastic",
                style: body3.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                StarDynamic(
                  rating: rating,
                ),
                SizedBox(width: 6.w),
                Text(
                  rating.toStringAsFixed(1),
                  style: heading4.copyWith(color: primary),
                ),
              ],
            ),
            Text(
              formatPrice(product.price),
              // product.price.toString(),
              style: heading3,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductTabs(ProductModel product, double rating) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: primary,
            tabs: [
              Tab(text: 'Details'),
              Tab(text: 'Reviews'),
            ],
          ),
          SizedBox(
            height: 200.h,
            child: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child:
                      Text(product.description ?? "No description available"),
                ),
                _buildReviewsSection(product, rating),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(ProductModel product, double rating) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: product.review != null && product.review.isNotEmpty
          ? ListView.separated(
              itemCount: product.review.length,
              separatorBuilder: (_, __) => Divider(color: Colors.grey.shade300),
              itemBuilder: (context, index) {
                final review = product.review[index];
                return ListTile(
                  title: Text(
                    review.user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Text(review.comment),
                      SizedBox(height: 6.h),
                      Row(
                        children: List.generate(5, (starIndex) {
                          if (starIndex < review.rating.floor()) {
                            return Icon(Icons.star,
                                color: Colors.amber, size: 16.w);
                          } else if (starIndex < review.rating &&
                              review.rating - starIndex >= 0.5) {
                            return Icon(Icons.star_half,
                                color: Colors.amber, size: 16.w);
                          } else {
                            return Icon(Icons.star_border,
                                color: Colors.amber, size: 16.w);
                          }
                        }),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                "No reviews yet for this product.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
    );
  }

  Widget _buildEnvironmentalImpact(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Environment Impact", style: heading4),
        SizedBox(height: 8.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Plastic Saved: ${product.plasticSaved} grams"),
            Text("Carbon Footprint: ${product.carbonSaved} kg CO2"),
            Text("Waste Saved: ${product.wasteSaved}"),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons({required bool isOwnProduct}) {
    final product = _productController.product!;

    if (isOwnProduct) {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => AddProductPage(
                      product: product,
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: Text(
                "Edit Product",
                style: body1.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
            ),
            onPressed: () {
              _cartController.addCart(productId: widget.id, amount: 1);
            },
            child: Text(
              "Add to Cart",
              style: body1.copyWith(color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _productController.getAllMyProducts();
              Get.to(() => CreateExchangeOfferPage(
                    product: product,
                    selectedSize: selectedSize,
                    selectedColor: selectedColor,
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff00C49A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
            ),
            child: Text(
              "Exchange",
              style: body1.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
