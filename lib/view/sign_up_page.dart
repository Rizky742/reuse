import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/widgets/auth_field.dart';
import 'package:reuse/widgets/custom_button.dart';
import 'package:reuse/theme.dart';
import 'package:get/get.dart';
import 'package:reuse/view/login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ikon panah kembali
          onPressed: () {
            Get.back();
          },
        ),
        // Hilangkan title dan actions jika tidak diperlukan
        automaticallyImplyLeading: false, // Nonaktifkan leading otomatis
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    // height: 30.h,
                    ),
                Text(
                  'Sign Up',
                  style: heading2.copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'Create your account',
                  style: caption1.copyWith(color: secondary),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: Container(
                    width: double.infinity,
                    height: 200.h,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Image.asset(
                      'assets/image_login.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 21.h,
                ),
                const AuthField(
                  title: "Nama",
                  hintText: "Masukkan nama",
                ),
                SizedBox(
                  height: 16.h,
                ),
                const AuthField(
                  title: "Email",
                  hintText: "Masukkan email",
                ),
                SizedBox(
                  height: 16.h,
                ),
                const AuthField(
                  title: "Password",
                  hintText: "Masukkan password",
                  isPassword: true,
                ),
                SizedBox(
                  height: 16.h,
                ),
                const AuthField(
                  title: "Confirm Password",
                  hintText: "Masukkan konfirmasi password",
                  isPassword: true,
                ),
                SizedBox(
                  height: 21.h,
                ),
                CustomButton(
                  title: "Sign Up",
                  onTap: () => Get.to(() => const LoginPage()),
                ),
                SizedBox(
                  height: 21.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        'Or with',
                        style: caption2.copyWith(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 21.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: caption2.copyWith(color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => const LoginPage()),
                      child: Text(
                        "Sign In",
                        style: caption2.copyWith(
                            color: primary, fontWeight: medium),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 21.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
