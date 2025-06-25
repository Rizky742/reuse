import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/exchange_controller.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/completed_exchanges_tab.dart';
import 'package:reuse/view/home_page.dart';
import 'package:reuse/view/home_screen.dart';
import 'package:reuse/view/offers_made_tab.dart';
import 'package:reuse/view/offers_received_tab.dart';

class ExchangePage extends StatefulWidget {
  final int initialTabIndex;
  final bool showBackButton;
  const ExchangePage(
      {super.key,
      this.initialTabIndex = 0,
      this.showBackButton = false}); // default ke tab pertama

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final exchangeController = Get.find<ExchangeController>();
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.initialTabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: widget.showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => {
                      productController.getAllMyProducts(),
                      Get.to(() => const HomePage(
                            initialIndex: 0,
                          ))
                    })
            : null, // jika false, tidak tampil
        title: Text(
          'Exchange with Users',
          style: heading3.copyWith(color: primary),
        ),
        bottom: TabBar(
          controller: _tabController,
          onTap: (value) {
            if (value == 0) {
              exchangeController.getOffersMade();
            } else if (value == 1) {
              exchangeController.getOffersReceived();
            }
            else {
              exchangeController.getCompletedOffer();
            }
          },
          labelColor: primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: primary,
          tabs: const [
            Tab(text: 'Offers Made'),
            Tab(text: 'Offers Received'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          OffersMadeTab(),
          OffersReceivedTab(),
          CompletedExchangesTab(),
        ],
      ),
    // floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       // Navigate to create new exchange page
    //       Get.snackbar(
    //         'Info',
    //         'Halaman pertukaran baru sedang dalam pengembangan',
    //         backgroundColor: Colors.blue,
    //         colorText: Colors.white,
    //         snackPosition: SnackPosition.BOTTOM,
    //       );
    //     },
    //     backgroundColor: primary,
    //     child: const Icon(Icons.add, color: Colors.white),
    //   ),
    );
  }
}
