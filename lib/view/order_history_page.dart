import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/transaction_controller.dart';

import 'package:reuse/theme.dart';
import 'package:reuse/widgets/order_card.dart';
import 'package:reuse/widgets/order_empty_state.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionController>();
    controller.getHistory();

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.historyTransaction.isEmpty) {
          return const OrderEmptyState();
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.historyTransaction.length,
            itemBuilder: (context, index) {
              final order = controller.historyTransaction[index];
              return OrderCard(order: order);
            },
          );
        }
      }),
    );
  }
}
