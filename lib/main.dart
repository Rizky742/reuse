
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/controllers/auth_controller.dart';
import 'package:reuse/controllers/cart_controller.dart';
import 'package:reuse/controllers/exchange_controller.dart';
import 'package:reuse/controllers/impact_controller.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/controllers/review_controller.dart';
import 'package:reuse/controllers/transaction_controller.dart';
import 'package:reuse/view/cart_page.dart';
import 'package:reuse/view/home_page.dart';
import 'package:reuse/view/login_page.dart';
import 'package:reuse/view/sign_up_page.dart';
import 'package:reuse/view/splash_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController()); // Inject controller at startup
  Get.put(ProductController()); // Inject controller at startup
  Get.put(ExchangeController()); // Inject controller at startup
  Get.put(ImpactController()); // Inject controller at startup
  Get.put(CartController()); // Inject controller at startup
  Get.put(TransactionController()); // Inject controller at startup
  Get.put(ReviewController()); // Inject controller at startup

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash', // Initial route name
        getPages: [
          GetPage(name: '/splash', page: () => const SplashScreen()),
          GetPage(name: '/login', page: () => const LoginPage()),
          GetPage(name: '/register', page: () => const SignUpPage()),
          GetPage(name: '/home', page: () => const HomePage()),
          GetPage(name: '/cart', page: () => const CartPage()),
          // Add other routes here
        ],
      ),
    );
  }
}
