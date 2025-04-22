import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/theme.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample order data
    final List<Map<String, dynamic>> orders = [
      {
        'orderId': 'ORD123456',
        'date': '15 Mei 2023',
        'status': 'Selesai',
        'total': 'Rp 125.000',
        'items': [
          {
            'name': 'Bamboo Straw Set',
            'quantity': 2,
            'price': 'Rp 45.000',
            'image': 'https://images.pexels.com/photos/4021976/pexels-photo-4021976.jpeg'
          },
          {
            'name': 'Reusable Bag',
            'quantity': 1,
            'price': 'Rp 35.000',
            'image': 'https://images.pexels.com/photos/5218021/pexels-photo-5218021.jpeg'
          }
        ]
      },
      {
        'orderId': 'ORD123123',
        'date': '20 April 2023',
        'status': 'Selesai',
        'total': 'Rp 70.000',
        'items': [
          {
            'name': 'Wooden Cutlery Set',
            'quantity': 1,
            'price': 'Rp 70.000',
            'image': 'https://images.pexels.com/photos/1080982/pexels-photo-1080982.jpeg'
          }
        ]
      },
      {
        'orderId': 'ORD120987',
        'date': '1 April 2023',
        'status': 'Selesai',
        'total': 'Rp 150.000',
        'items': [
          {
            'name': 'Eco-friendly Water Bottle',
            'quantity': 1,
            'price': 'Rp 85.000',
            'image': 'https://images.pexels.com/photos/4590274/pexels-photo-4590274.jpeg'
          },
          {
            'name': 'Reusable Coffee Cup',
            'quantity': 1,
            'price': 'Rp 65.000',
            'image': 'https://images.pexels.com/photos/8148098/pexels-photo-8148098.jpeg'
          }
        ]
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Pemesanan',
          style: heading3.copyWith(color: primary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: orders.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(order);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80.w,
            color: Colors.grey,
          ),
          SizedBox(height: 16.h),
          Text(
            'Belum ada pesanan',
            style: heading3.copyWith(color: Colors.grey[600]),
          ),
          SizedBox(height: 8.h),
          Text(
            'Anda belum membuat pesanan apapun',
            style: body2.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text('Mulai Berbelanja'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
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
          // Order header
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID: ${order['orderId']}',
                      style: body2.copyWith(fontWeight: semiBold),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      order['date'],
                      style: caption1.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    order['status'],
                    style: caption2.copyWith(
                      color: Colors.white,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Order items
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order['items'].length,
            itemBuilder: (context, index) {
              final item = order['items'][index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    item['image'],
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  item['name'],
                  style: body2.copyWith(fontWeight: semiBold),
                ),
                subtitle: Text(
                  '${item['quantity']} x ${item['price']}',
                  style: caption1.copyWith(color: Colors.grey[600]),
                ),
                trailing: Text(
                  item['price'],
                  style: body2.copyWith(fontWeight: semiBold),
                ),
              );
            },
          ),

          // Order footer
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Pesanan',
                  style: body2.copyWith(fontWeight: semiBold),
                ),
                Text(
                  order['total'],
                  style: heading3.copyWith(
                    color: primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Order actions
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // View order details
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Detail',
                      style: body2.copyWith(color: primary),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Order again
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Text('Pesan Lagi'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 