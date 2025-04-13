import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reuse/widgets/auth_field.dart';
import 'package:reuse/widgets/custom_button.dart';
import 'package:reuse/theme.dart';
import 'package:get/get.dart';
import 'package:reuse/view/home_page.dart';
import 'package:reuse/view/sign_up_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Welcome Back',
                  style: heading2.copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'Sign in to your page',
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
                  height: 21.h,
                ),
                CustomButton(
                  title: "Login",
                  onTap: () => Get.to(() => const HomePage()),
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
                      "Don’t have an account?",
                      style: caption2.copyWith(color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => const SignUpPage()),
                      child: Text(
                        "Sign Up",
                        style: caption2.copyWith(
                            color: primary, fontWeight: medium),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 21.h,
                ),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/google_logo.svg', // Pastikan path ini benar
                        width: 20.w,
                        height: 20.w,
                      ),
                      SizedBox(width: 8.w), // Spasi antara ikon dan teks
                      Text(
                        "Google",
                        style: body1.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
