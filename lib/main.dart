import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:reuse/view/home_page.dart';
import 'package:reuse/view/login_page.dart';
import 'package:reuse/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: Size(360, 800),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',  // Initial route name
        getPages: [
          GetPage(name: '/splash', page: () => SplashScreen()),
          GetPage(name: '/login', page: () => LoginPage()),
          GetPage(name: '/home', page: () => HomePage()),
          // Add other routes here
        ],
      ),
    );
  }
}

