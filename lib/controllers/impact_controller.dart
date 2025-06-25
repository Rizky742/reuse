import 'package:get/get.dart';
import 'package:reuse/models/impact_model.dart';
import 'package:reuse/services/impact_service.dart';

class ImpactController extends GetxController {
  static ImpactController get instance => Get.find();
  final Rx<ImpactModel?> _impact = Rx<ImpactModel?>(null);
  final RxBool isLoading = false.obs;
  ImpactModel? get impact => _impact.value;

  Future<void> getMyImpact() async {
    try {
      isLoading(true);
      final result = await ImpactService.getMyImpact();
      // await Future.delayed(const Duration(seconds: 4));
      _impact.value = result;
      isLoading(false);
    } catch (e) {
      Get.snackbar(
        'Fetch Impact Failed',
        e.toString().replaceAll('Exception: ', ''), // agar pesan lebih bersih
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
