import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/cart_controller.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/controllers/review_controller.dart';
import 'package:reuse/controllers/transaction_controller.dart';
import 'package:reuse/models/cart_model.dart';
import 'package:reuse/models/review_model.dart';
import 'package:reuse/models/reviews_model.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/utils/formatPrice.dart';
import 'package:reuse/view/home_page.dart';

class ConfirmPaymentPage extends StatelessWidget {
  final List<CartModel> cartItems;

  const ConfirmPaymentPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController =
        Get.find<TransactionController>();
    // final TransactionController cartController = Get.find<CartController>();
    final totalPrice = cartItems.fold<int>(
      0,
      (sum, item) => sum + (item.product.price * item.amount),
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title:
            Text('Confirm Payment', style: heading3.copyWith(color: primary)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Method Section
            _buildSectionCard(
              title: 'Payment Method',
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bank Transfer',
                          style: body3.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'BCA Virtual Account',
                          style: body3.copyWith(
                            color: Colors.grey[600],
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Shipping Address Section
            _buildSectionCard(
              title: 'Shipping Address',
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: primary,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: body3.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Jl. Kenangan No. 1, Jakarta Selatan\nDKI Jakarta 12345',
                            style: body3.copyWith(
                              color: Colors.grey[600],
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              '0812-3456-7890',
                              style: body3.copyWith(
                                color: primary,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Order Summary Section
            _buildSectionCard(
              title: 'Order Summary',
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    // Product items
                    ...cartItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.network(
                                  'https://api.reuse.ngodingbareng.my.id${item.product.imageUrl}',
                                  width: 50.w,
                                  height: 50.w,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 50.w,
                                      height: 50.w,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: Icon(
                                        Icons.shopping_bag_outlined,
                                        color: Colors.grey[400],
                                        size: 20.sp,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: body3.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      'Qty: ${item.amount}',
                                      style: body3.copyWith(
                                        color: Colors.grey[600],
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                formatPrice(item.product.price * item.amount),
                                style: body3.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
                            ],
                          ),
                          if (index < cartItems.length - 1)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Divider(color: Colors.grey[200]),
                            ),
                        ],
                      );
                    }),

                    SizedBox(height: 16.h),
                    Divider(color: Colors.grey[300]),
                    SizedBox(height: 12.h),

                    // Subtotal and fees
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: body3.copyWith(color: Colors.grey[600]),
                        ),
                        Text(
                          formatPrice(totalPrice),
                          style: body3.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Fee',
                          style: body3.copyWith(color: Colors.grey[600]),
                        ),
                        Text(
                          'Free',
                          style: body3.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Divider(color: Colors.grey[300]),
                    SizedBox(height: 12.h),

                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Payment',
                          style: heading4.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          formatPrice(totalPrice),
                          style: heading4.copyWith(
                            color: primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: () async {
                // _showPaymentSuccessDialog(context);
                final success = await transactionController.createTransaction(
                    cart: cartItems);
                if (!context.mounted) return;

                if (success) {
                  _showPaymentSuccessDialog(context); // sekarang aman!
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.payment,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Pay ${formatPrice(totalPrice)}',
                    style: body3.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
          child: Text(
            title,
            style: heading4.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ),
        child,
      ],
    );
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        contentPadding: EdgeInsets.all(24.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: primary,
                size: 40.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Payment Successful!",
              style: heading4.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              "Thank you for your purchase!\nYour order will be processed soon.",
              style: body3.copyWith(
                color: Colors.grey[600],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showReviewModal(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primary),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Rate & Review',
                      style: body3.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final productController = Get.find<ProductController>();
                      productController.getAllProducts();

                      Get.offAll(() => const HomePage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
                      style: body3.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // void _showReviewModal(BuildContext context) {
  //   final Map<String, int> ratings = {};
  //   final Map<String, TextEditingController> reviewControllers = {};

  //   // Initialize controllers for each product
  //   for (var item in cartItems) {
  //     ratings[item.product.id] = 0;
  //     reviewControllers[item.product.id] = TextEditingController();
  //   }

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => StatefulBuilder(
  //       builder: (context, setState) => Container(
  //         height: MediaQuery.of(context).size.height * 0.8,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
  //         ),
  //         child: Column(
  //           children: [
  //             // Handle bar
  //             Container(
  //               margin: EdgeInsets.only(top: 8.h),
  //               width: 40.w,
  //               height: 4.h,
  //               decoration: BoxDecoration(
  //                 color: Colors.grey[300],
  //                 borderRadius: BorderRadius.circular(2.r),
  //               ),
  //             ),

  //             // Header
  //             Padding(
  //               padding: EdgeInsets.all(20.w),
  //               child: Row(
  //                 children: [
  //                   Text(
  //                     'Rate Your Purchase',
  //                     style: heading4.copyWith(
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   const Spacer(),
  //                   GestureDetector(
  //                     onTap: () => Navigator.pop(context),
  //                     child: Container(
  //                       width: 32.w,
  //                       height: 32.w,
  //                       decoration: BoxDecoration(
  //                         color: Colors.grey[100],
  //                         shape: BoxShape.circle,
  //                       ),
  //                       child: Icon(
  //                         Icons.close,
  //                         size: 18.sp,
  //                         color: Colors.grey[600],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),

  //             // Products list
  //             Expanded(
  //               child: ListView.separated(
  //                 padding: EdgeInsets.symmetric(horizontal: 20.w),
  //                 itemCount: cartItems.length,
  //                 separatorBuilder: (context, index) => Divider(
  //                   height: 24.h,
  //                   color: Colors.grey[200],
  //                 ),
  //                 itemBuilder: (context, index) {
  //                   final item = cartItems[index];
  //                   return Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       // Product info
  //                       Row(
  //                         children: [
  //                           ClipRRect(
  //                             borderRadius: BorderRadius.circular(8.r),
  //                             child: Image.network(
  //                               'https://api.reuse.ngodingbareng.my.id${item.product.imageUrl}' ??
  //                                   'https://via.placeholder.com/50',
  //                               width: 50.w,
  //                               height: 50.w,
  //                               fit: BoxFit.cover,
  //                               errorBuilder: (context, error, stackTrace) {
  //                                 return Container(
  //                                   width: 50.w,
  //                                   height: 50.w,
  //                                   decoration: BoxDecoration(
  //                                     color: Colors.grey[100],
  //                                     borderRadius: BorderRadius.circular(8.r),
  //                                   ),
  //                                   child: Icon(
  //                                     Icons.shopping_bag_outlined,
  //                                     color: Colors.grey[400],
  //                                     size: 20.sp,
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           ),
  //                           SizedBox(width: 12.w),
  //                           Expanded(
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Text(
  //                                   item.product.name,
  //                                   style: body3.copyWith(
  //                                     fontWeight: FontWeight.w500,
  //                                   ),
  //                                   maxLines: 1,
  //                                   overflow: TextOverflow.ellipsis,
  //                                 ),
  //                                 SizedBox(height: 2.h),
  //                                 Text(
  //                                   'Qty: ${item.amount}',
  //                                   style: body3.copyWith(
  //                                     color: Colors.grey[600],
  //                                     fontSize: 12.sp,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),

  //                       SizedBox(height: 16.h),

  //                       // Star rating
  //                       Row(
  //                         children: [
  //                           ...List.generate(5, (starIndex) {
  //                             return GestureDetector(
  //                               onTap: () {
  //                                 setState(() {
  //                                   ratings[item.product.id] = starIndex + 1;
  //                                 });
  //                               },
  //                               child: Container(
  //                                 padding: EdgeInsets.all(2.w),
  //                                 child: Icon(
  //                                   Icons.star,
  //                                   size: 24.sp,
  //                                   color: starIndex <
  //                                           (ratings[item.product.id] ?? 0)
  //                                       ? Colors.amber
  //                                       : Colors.grey[300],
  //                                 ),
  //                               ),
  //                             );
  //                           }),
  //                           SizedBox(width: 8.w),
  //                           if ((ratings[item.product.id] ?? 0) > 0)
  //                             Text(
  //                               _getRatingText(ratings[item.product.id]!),
  //                               style: body3.copyWith(
  //                                 color: _getRatingColor(
  //                                     ratings[item.product.id]!),
  //                                 fontSize: 12.sp,
  //                               ),
  //                             ),
  //                         ],
  //                       ),

  //                       SizedBox(height: 12.h),

  //                       // Review text field
  //                       Container(
  //                         height: 80.h,
  //                         padding: EdgeInsets.all(12.w),
  //                         decoration: BoxDecoration(
  //                           border: Border.all(color: Colors.grey[300]!),
  //                           borderRadius: BorderRadius.circular(8.r),
  //                         ),
  //                         child: TextField(
  //                           controller: reviewControllers[item.product.id],
  //                           maxLines: null,
  //                           expands: true,
  //                           decoration: InputDecoration(
  //                             hintText: 'Write your review...',
  //                             hintStyle: body3.copyWith(
  //                               color: Colors.grey[500],
  //                               fontSize: 12.sp,
  //                             ),
  //                             border: InputBorder.none,
  //                           ),
  //                           style: body3.copyWith(fontSize: 12.sp),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               ),
  //             ),

  //             // Submit button
  //             Container(
  //               padding: EdgeInsets.all(20.w),
  //               child: SizedBox(
  //                 width: double.infinity,
  //                 height: 48.h,
  //                 child: ElevatedButton(
  //                   onPressed: () {
  //                     final controller = Get.find<ReviewController>();
  //                     // Collect review data
  //                     List<ReviewsModel> reviews = [];
  //                     for (var item in cartItems) {
  //                       final rating = ratings[item.product.id] ?? 0;
  //                       if (rating > 0) {
  //                         // reviews.add({
  //                         //   'productId': item.product.id,
  //                         //   'productName': item.product.name,
  //                         //   'rating': rating,
  //                         //   'review':
  //                         //       reviewControllers[item.product.id]?.text ?? '',
  //                         //   'timestamp': DateTime.now().toIso8601String(),
  //                         // });
  //                         reviews.add(ReviewsModel(
  //                             rating: rating,
  //                             comment:
  //                                 reviewControllers[item.product.id]?.text ??
  //                                     '',
  //                             productId: item.product.id));
  //                       }
  //                     }

  //                     // Close modal and show thank you
  //                     Navigator.pop(context);
  //                     _showThankYouDialog(reviews, context);

  //                     // Dispose controllers
  //                     for (var controller in reviewControllers.values) {
  //                       controller.dispose();
  //                     }
  //                             controller.addReview(reviews: reviews);
  //                   },
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: primary,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(12.r),
  //                     ),
  //                   ),
  //                   child: Text(
  //                     'Submit Review',
  //                     style: body3.copyWith(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showReviewModal(BuildContext context) {
    final Map<String, int> ratings = {};
    final Map<String, TextEditingController> reviewControllers = {};

    // Initialize controllers for each product
    for (var item in cartItems) {
      ratings[item.product.id] = 0;
      reviewControllers[item.product.id] = TextEditingController();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Header
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Text(
                      'Rate Your Purchase',
                      style: heading4.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Dispose controllers before closing
                        for (var controller in reviewControllers.values) {
                          controller.dispose();
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 18.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Products list
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: cartItems.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 24.h,
                    color: Colors.grey[200],
                  ),
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product info
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.network(
                                'https://api.reuse.ngodingbareng.my.id${item.product.imageUrl}',
                                width: 50.w,
                                height: 50.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 50.w,
                                    height: 50.w,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Icon(
                                      Icons.shopping_bag_outlined,
                                      color: Colors.grey[400],
                                      size: 20.sp,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: body3.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    'Qty: ${item.amount}',
                                    style: body3.copyWith(
                                      color: Colors.grey[600],
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        // Star rating
                        Row(
                          children: [
                            ...List.generate(5, (starIndex) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ratings[item.product.id] = starIndex + 1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2.w),
                                  child: Icon(
                                    Icons.star,
                                    size: 24.sp,
                                    color: starIndex <
                                            (ratings[item.product.id] ?? 0)
                                        ? Colors.amber
                                        : Colors.grey[300],
                                  ),
                                ),
                              );
                            }),
                            SizedBox(width: 8.w),
                            if ((ratings[item.product.id] ?? 0) > 0)
                              Text(
                                _getRatingText(ratings[item.product.id]!),
                                style: body3.copyWith(
                                  color: _getRatingColor(
                                      ratings[item.product.id]!),
                                  fontSize: 12.sp,
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        // Review text field
                        Container(
                          height: 80.h,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: TextField(
                            controller: reviewControllers[item.product.id],
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              hintText: 'Write your review...',
                              hintStyle: body3.copyWith(
                                color: Colors.grey[500],
                                fontSize: 12.sp,
                              ),
                              border: InputBorder.none,
                            ),
                            style: body3.copyWith(fontSize: 12.sp),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Submit button
              Container(
                padding: EdgeInsets.all(20.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      final controller = Get.find<ReviewController>();

                      // Collect review data
                      List<ReviewsModel> reviews = [];
                      for (var item in cartItems) {
                        final rating = ratings[item.product.id] ?? 0;
                        if (rating > 0) {
                          reviews.add(ReviewsModel(
                            rating: rating,
                            comment:
                                reviewControllers[item.product.id]?.text ?? '',
                            productId: item.product.id,
                          ));
                        }
                      }

                      // Submit reviews

                      // Dispose controllers before closing
                      for (var textController in reviewControllers.values) {
                        textController.dispose();
                      }
                      await controller.addReview(reviews: reviews);

                      // Close modal
                      // if (context.mounted) {
                      //   Navigator.pop(context);
                      //   _showThankYouDialog(reviews, context);
                      // }
                      if (context.mounted) {
                        Navigator.pop(context);
                        Future.delayed(Duration.zero, () {
                          if (context.mounted) {
                            _showThankYouDialog(reviews, context);
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Submit Review',
                      style: body3.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      // Dispose controllers when modal is completely closed
      for (var controller in reviewControllers.values) {
        controller.dispose();
      }
    });
  }

  void _showThankYouDialog(List<ReviewsModel> reviews, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        contentPadding: EdgeInsets.all(24.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.thumb_up,
                color: primary,
                size: 30.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Thank You!",
              style: heading4.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Your review helps other customers",
              style: body3.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print('object');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Done',
                  style: body3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Here you would send the reviews to your backend
    print('Reviews submitted: $reviews');
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 1:
      case 2:
        return Colors.red;
      case 3:
        return Colors.orange;
      case 4:
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
