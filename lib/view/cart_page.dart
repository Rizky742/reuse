import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/confirm_payment.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
final List<Map<String, dynamic>> items = [
  {'title': 'Nike Jordan Used', 'price': 500000},
  {'title': 'Wooden Spoon', 'price': 500000},
  {'title': 'Nike Jordan Used', 'price': 500000},
];

    int total = items.fold(0, (sum, item) => sum + (item['price'] as int));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Cart',
          style: heading3.copyWith(color: primary),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
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
                          child: Image.asset(
                            'assets/shoes.jpg',
                            width: 80.w,
                            height: 80.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['title']!, style: heading4),
                              Text('Rp ${item['price']}', style: heading4.copyWith(fontWeight: FontWeight.bold)),
                              Text('Size: 41', style: body3),
                              Text('Color: Green', style: body3),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Icon(Icons.remove_circle, size: 20.w),
                                  SizedBox(width: 6.w),
                                  Text('8'),
                                  SizedBox(width: 6.w),
                                  Icon(Icons.add_circle, size: 20.w),
                                ],
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () {},
                        )
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
                boxShadow: [
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
                  Divider(),
                  buildPriceRow('Sub Total', 0),
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
                    MaterialPageRoute(builder: (_) => const ConfirmPaymentPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Add to Cart',
                  style: body3.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget buildPriceRow(String label, int value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: body3),
          Text('Rp ${value.toString()}', style: body3),
        ],
      ),
    );
  }
}
