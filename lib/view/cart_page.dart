import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/controllers/cart_controller.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/utils/formatPrice.dart';
import 'package:reuse/view/confirm_payment.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    // Panggil getCart saat halaman dimuat
    cartController.getCart();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text('Cart', style: heading3.copyWith(color: primary)),
      ),
      body: Obx(() {
        if (cartController.isLoading.value &&
            !cartController.isUpdating.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final cartItems = cartController.cart;

        if (cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100.w,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 20.h),
                Text(
                  'Keranjang kamu masih kosong',
                  style: heading4.copyWith(color: Colors.grey[600]),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Yuk mulai belanja dan temukan barang favoritmu!',
                  style: body3.copyWith(color: Colors.grey[500]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(
                        '/home'); // Ganti dengan route ke halaman produk/home
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Mulai Belanja',
                    style: body3.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        }
        final total = cartItems.fold<int>(
            0, (sum, item) => sum + (item.product.price) * (item.amount));

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              Expanded(
                child: ListView.separated(
                  itemCount: cartItems.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              'https://api.reuse.ngodingbareng.my.id${item.product.imageUrl}',
                              width: 80.w,
                              height: 80.w,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 80.w,
                                height: 80.w,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.product?.name ?? '-',
                                    style: heading4),
                                Text(
                                  formatPrice(item.product.price),
                                  style: heading4.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('Size: -', style: body3),
                                Text('Color: -', style: body3),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        final newAmount =
                                            (item.amount ?? 1) - 1;
                                        if (newAmount > 0) {
                                          cartController.updateCart(
                                            id: item.id!,
                                            amount: newAmount,
                                          );
                                        }
                                      },
                                      child:
                                          Icon(Icons.remove_circle, size: 20.w),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text('${item.amount ?? 1}'),
                                    SizedBox(width: 6.w),
                                    GestureDetector(
                                      onTap: () {
                                        cartController.updateCart(
                                          id: item.id!,
                                          amount: (item.amount ?? 1) + 1,
                                        );
                                      },
                                      child: Icon(Icons.add_circle, size: 20.w),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              cartController.deleteCart(id: item.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    buildPriceRow('Total', total),
                    buildPriceRow('Discount', 0),
                    buildPriceRow('Delivery Fee', 0),
                    const Divider(),
                    buildPriceRow('Sub Total', total),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>  ConfirmPaymentPage(cartItems: cartItems,),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Continue to Payment',
                    style: body3.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      }),
    );
  }

  Widget buildPriceRow(String label, int value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: body3),
          Text(formatPrice(value), style: body3),
        ],
      ),
    );
  }
}
