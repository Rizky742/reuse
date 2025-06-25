import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/auth_controller.dart'; // ADD THIS
import 'package:reuse/widgets/auth_field.dart';
import 'package:reuse/widgets/custom_button.dart';
import 'package:reuse/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // Track loading state

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>(); // USE CONTROLLER

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                'Welcome Back',
                style: heading2.copyWith(color: Colors.black),
              ),
              SizedBox(height: 6.h),
              Text(
                'Sign in to your page',
                style: caption1.copyWith(color: secondary),
              ),
              SizedBox(height: 10.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: Image.asset(
                    'assets/image_login.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 21.h),
              AuthField(
                title: "Email",
                hintText: "Masukkan email",
                controller: emailController,
              ),
              SizedBox(height: 16.h),
              AuthField(
                title: "Password",
                hintText: "Masukkan password",
                isPassword: true,
                controller: passwordController,
              ),
              SizedBox(height: 21.h),
              CustomButton(
                title: isLoading ? '' : "Login",  // Hide text when loading
                onTap: () async {
                  setState(() {
                    isLoading = true;  // Start loading
                  });

                  try {
                    await authController.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  } catch (e) {
                    Get.snackbar("Login Failed", e.toString(),
                        backgroundColor: Colors.redAccent, colorText: Colors.white);
                  } finally {
                    setState(() {
                      isLoading = false;  // Stop loading after login attempt
                    });
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : null,  // Show loading indicator if isLoading is true
              ),
              SizedBox(height: 21.h),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text('Or with', style: caption2.copyWith(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                ],
              ),
              SizedBox(height: 21.h),
              GestureDetector(
                onTap: () async {
                  // await authController.signInWithGoogle();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/google_logo.svg', width: 20.w, height: 20.w),
                      SizedBox(width: 8.w),
                      Text(
                        "Google",
                        style: body1.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 21.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: caption2.copyWith(color: Colors.grey)),
                  InkWell(
                    onTap: () => Get.toNamed('/register'),
                    child: Text(
                      " Sign Up",
                      style: caption2.copyWith(color: primary, fontWeight: medium),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
