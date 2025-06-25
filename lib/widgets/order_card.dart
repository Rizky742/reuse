import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/models/transaction_model.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/utils/formatDate.dart';
import 'package:reuse/utils/formatPrice.dart';

class OrderCard extends StatelessWidget {
  final TransactionModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order ID: ${order.id}', style: body2.copyWith(fontWeight: semiBold), overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 4.h),
                      Text(formatToLocalDate(order.transactionDate), style: caption1.copyWith(color: Colors.grey[600])),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "Selesai",
                    style: caption2.copyWith(color: Colors.white, fontWeight: semiBold),
                  ),
                ),
              ],
            ),
          ),

          // Items
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.details.length,
            itemBuilder: (context, index) {
              final item = order.details[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    'https://api.reuse.ngodingbareng.my.id${item.product.imageUrl}',
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(item.product.name, style: body2.copyWith(fontWeight: semiBold)),
                subtitle: Text('${item.quantity} x ${formatPrice(item.product.price)}', style: caption1.copyWith(color: Colors.grey[600])),
                trailing: Text(formatPrice(item.product.price), style: body2.copyWith(fontWeight: semiBold)),
              );
            },
          ),

          // Footer
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Pesanan', style: body2.copyWith(fontWeight: semiBold)),
                Text(formatPrice(order.totalPrice), style: heading3.copyWith(color: primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // Actions
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: OutlinedButton(
          //           onPressed: () {
          //             // Handle detail
          //           },
          //           style: OutlinedButton.styleFrom(
          //             side: const BorderSide(color: primary),
          //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          //           ),
          //           child: Text('Detail', style: body2.copyWith(color: primary)),
          //         ),
          //       ),
          //       SizedBox(width: 12.w),
          //       Expanded(
          //         child: ElevatedButton(
          //           onPressed: () {
          //             // Handle repeat
          //           },
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: primary,
          //             foregroundColor: Colors.white,
          //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          //           ),
          //           child: const Text('Pesan Lagi'),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
