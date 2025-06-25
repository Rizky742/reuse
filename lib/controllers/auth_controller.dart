import 'package:get/get.dart';
import 'package:reuse/models/user_model.dart';
import 'package:reuse/services/auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final Rxn<UserModel> _user = Rxn<UserModel>();
  UserModel? get user => _user.value;


  void setUser(UserModel user) {
    _user.value = user;
  }

  // Login method
  Future<void> login(String email, String password) async {
    try {
      final user = await AuthService.login(email: email, password: password);
      setUser(user);
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString().replaceAll('Exception: ', ''), // agar pesan lebih bersih
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
        duration: const Duration(seconds: 3),
      );
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      // await AuthService.logout();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Logout Failed',
        e.toString(),
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  // // Google Sign In method
  // Future<void> signInWithGoogle() async {
  //   try {
  //     // await AuthService.signInWithGoogle();
  //     Get.offAllNamed('/home');
  //   } catch (e) {
  //     Get.snackbar(
  //       'Google Sign-In Failed',
  //       e.toString(),
  //       backgroundColor: Get.theme.colorScheme.error,
  //       colorText: Get.theme.colorScheme.onError,
  //     );
  //   }
  // }

  // Register method
  Future<void> register(
      String name, String email, String password, String noHp) async {
    try {
      await AuthService.register(
          name: name, email: email, password: password, noHp: noHp);
      Get.offAllNamed('/home');
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Registration Failed',
        e.toString(),
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }
}
