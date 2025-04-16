import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/home_page.dart'; // Pastikan file ini ada dan sesuai

class ConfirmPaymentPage extends StatelessWidget {
  const ConfirmPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirm Payment',
          style: heading3.copyWith(color: primary),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Method', style: heading4),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: primary),
                  SizedBox(width: 12.w),
                  Text('Bank Transfer (BCA)', style: body3),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            Text('Shipping Address', style: heading4),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('John Doe', style: body3.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.h),
                  Text('Jl. Kenangan No. 1, Jakarta', style: body3),
                  SizedBox(height: 4.h),
                  Text('0812-3456-7890', style: body3),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            Text('Order Summary', style: heading4),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nike Jordan Used', style: body3),
                Text('Rp 500.000', style: body3),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Fee', style: body3),
                Text('Rp 0', style: body3),
              ],
            ),
            Divider(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: heading4),
                Text('Rp 500.000', style: heading4.copyWith(color: primary)),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implementasi logika pembayaran
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Payment Successful"),
                      content: Text("Thank you for your purchase!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.to(() => HomePage());
                           
                          },
                          child: Text("OK"),
                        )
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Pay Now',
                  style: body3.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
