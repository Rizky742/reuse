import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/exchange_controller.dart';
import 'package:reuse/models/exchange_model.dart';
import 'package:reuse/widgets/empty_state_exchange.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reuse/widgets/exchange_card.dart';

class OffersMadeTab extends StatelessWidget {
  
  const OffersMadeTab({super.key});

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
    exchangeController.getOffersMade();

    return Obx(
      () {
        if (exchangeController.isLoadingMade.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (exchangeController.offersMade.isEmpty) {
          return const EmptyStateExchange(mode: "Offers Made",);
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: exchangeController.offersMade.length,
          itemBuilder: (context, index) {
            final exchange = exchangeController.offersMade[index];
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
