import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/exchange_controller.dart';
import 'package:reuse/models/exchange_model.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/utils/formatDate.dart';
import 'package:reuse/widgets/empty_state_exchange.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reuse/widgets/exchange_card.dart';

class OffersReceivedTab extends StatelessWidget {
  const OffersReceivedTab({super.key});

 void openWhatsApp(String phone, String message) async {
  final url = 'https://wa.me/$phone?text=${Uri.encodeComponent(message)}';

  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
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
    exchangeController.getOffersReceived();

    return Obx(
      () {
        if (exchangeController.isLoadingReceived.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (exchangeController.offersReceived.isEmpty) {
              return const EmptyStateExchange(mode: "Offers Received",);
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: exchangeController.offersReceived.length,
          itemBuilder: (context, index) {
            final exchange = exchangeController.offersReceived[index];
            return ExchangeCard(
              exchange: exchange,
              isOfferMade: false,
              openWhatsApp: openWhatsApp,
            );
          },
        );
      },
    );
  }
}
