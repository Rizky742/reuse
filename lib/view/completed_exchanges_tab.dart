import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/exchange_controller.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/widgets/empty_state_exchange.dart';
import 'package:reuse/widgets/exchange_card.dart';
import 'package:url_launcher/url_launcher.dart';

class CompletedExchangesTab extends StatelessWidget {
  const CompletedExchangesTab({super.key});

  void openWhatsApp(String phone, String message) async {
    final uri =
        Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar(
        'Error',
        'Tidak dapat membuka WhatsApp',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final exchangeController = Get.find<ExchangeController>();
    exchangeController.getCompletedOffer();

    return Obx(
      () {
        if (exchangeController.isLoadingCompleted.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (exchangeController.offersCompleted.isEmpty) {
          return const EmptyStateExchange(
            mode: "Offers Completed",
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: exchangeController.offersCompleted.length,
          itemBuilder: (context, index) {
            final exchange = exchangeController.offersCompleted[index];
            return ExchangeCard(
              exchange: exchange,
              isOfferMade: true,
              openWhatsApp: openWhatsApp,
            );
          },
        );
      },
    );
  }
}
