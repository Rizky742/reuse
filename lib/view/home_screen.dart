import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reuse/widgets/empty_state_home.dart';
import 'package:shimmer/shimmer.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/models/user_model.dart';
import 'package:reuse/services/auth_service.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/product_page.dart';
import 'package:reuse/widgets/header_home.dart';
import 'package:reuse/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController _productController = Get.find<ProductController>();
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      await _productController.getAllProducts();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load products',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void loadUser() async {
    UserModel? loadedUser = await AuthService.getUserFromPrefs();
    setState(() {
      user = loadedUser;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 28.h),
            const HeaderHome(),
            SizedBox(height: 28.h),
            _buildSearchBar(),
            SizedBox(height: 28.h),
            Expanded(
              child: Obx(() {
                if (_productController.errorMessage.value.isNotEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64.w,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        _productController.errorMessage.value,
                        textAlign: TextAlign.center,
                        style: body1.copyWith(color: Colors.grey),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: _loadProducts,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Retry',
                          style: body1.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                }

                if (_productController.products.isEmpty) {
                  return EmptyStateHome(
                    onRetry: _loadProducts,
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => _loadProducts(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: _buildProductGrid(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: 6, // Show 6 shimmer items
      itemBuilder: (context, index) {
        return _buildShimmerCard();
      },
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image shimmer
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer
                  Container(
                    height: 16.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Subtitle shimmer
                  Container(
                    height: 12.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price shimmer
                      Container(
                        height: 14.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      // Rating shimmer
                      Row(
                        children: [
                          Container(
                            height: 12.h,
                            width: 12.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            height: 12.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search Food",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 16.w,
              ),
              prefixIcon: const Icon(Icons.search, color: primary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: primary),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SvgPicture.asset(
            'assets/filter_logo.svg',
            width: 20.w,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: _productController.products.length,
      itemBuilder: (context, index) {
        final product = _productController.products[index];
        final rating = double.tryParse(product.averageRating) ?? 0.0;

        return GestureDetector(
          onTap: () {
            _productController.getProduct(id: product.id);
            Get.to(() => ProductPage(
                  id: product.id,
                  isMyProduct: product.user.id == user?.id,
                ));
          },
          child: ProductCard(
            isOwnProduct: product.user.id == user?.id,
            rating: rating,
            title: product.name,
            imageUrl: "https://api.reuse.ngodingbareng.my.id${product.imageUrl}",
            subtitle: "",
            price: product.price,
          ),
        );
      },
    );
  }
}
