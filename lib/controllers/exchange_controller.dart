import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/models/exchange_model.dart';
import 'package:reuse/services/exchange_service.dart';
import 'package:reuse/view/exchange_page.dart';
import 'package:reuse/view/home_page.dart';

class ExchangeController extends GetxController {
    static ExchangeController get instance => Get.find();

  final RxList<ExchangeModel> _offersMade = <ExchangeModel>[].obs;
  final RxList<ExchangeModel> _offersReceived = <ExchangeModel>[].obs;
  final RxList<ExchangeModel> _offersCompleted = <ExchangeModel>[].obs;

  List<ExchangeModel> get offersMade => _offersMade;
  List<ExchangeModel> get offersReceived => _offersReceived;
  List<ExchangeModel> get offersCompleted => _offersCompleted;

  final RxBool isLoadingMade = false.obs;
  final RxBool isLoadingCompleted = false.obs;
  final RxBool isLoadingReceived = false.obs;
  final RxBool isSubmittingOffer = false.obs;

  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getOffersMade();
    getOffersReceived();
  }

  Future<void> createOffer({
    required String receiverId,
    required String receiverProductId,
    required String requesterProductId,
    required String notes,
  }) async {
    try {
      isSubmittingOffer(true);
      errorMessage('');
      await ExchangeService.createOffer(
          receiverId: receiverId,
          notes: notes,
          receiverProductId: receiverProductId,
          requesterProductId: requesterProductId);
      final productController = Get.find<ProductController>();
      await productController.getAllMyProducts();
      await getOffersMade();
      Get.to(() =>  const ExchangePage(initialTabIndex: 0, showBackButton: true,));
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isSubmittingOffer(false);
    }
  }

  Future<void> getOffersMade() async {
    try {
      isLoadingMade(true);
      errorMessage('');
      final offersMade = await ExchangeService.getOffersMade();
      _offersMade.value = offersMade;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      _offersMade.value = []; // Clear previous data on error
    } finally {
      isLoadingMade(false);
    }
  }

  Future<void> upateStatusOffer(
      {required String id, required String status,  String? metode}) async {
    try {
      isSubmittingOffer(true);
      errorMessage('');
      await ExchangeService.updateStatusOffer(id: id, status: status, metode: metode);
      await getOffersMade();
      await getOffersReceived();
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Tawaran pertukaran telah dibatalkan',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isSubmittingOffer(false);
    }
  }

  Future<void> getOffersReceived() async {
    try {
      isLoadingReceived(true);
      errorMessage('');
      final offersReceived = await ExchangeService.getOffersReceived();
      _offersReceived.value = offersReceived;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      _offersReceived.value = []; // Clear previous data on error
    } finally {
      isLoadingReceived(false);
    }
  }

   Future<void> getCompletedOffer() async {
    try {
      isLoadingCompleted(true);
      errorMessage('');
      final offersCompleted = await ExchangeService.getCompletedOffer();
      _offersCompleted.value = offersCompleted;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      _offersCompleted.value = []; // Clear previous data on error
    } finally {
      isLoadingCompleted(false);
    }
  }
}
