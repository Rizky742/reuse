import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/widgets/auth_field.dart';
import 'package:reuse/widgets/custom_button.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/login_page.dart';
import 'package:reuse/controllers/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final noHpController = TextEditingController();
  final confirmController = TextEditingController();
  bool isLoading = false;  // Track loading state
  final AuthController authController = AuthController.instance;

  @override
  void dispose() {
    noHpController.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign Up', style: heading2.copyWith(color: Colors.black)),
              SizedBox(height: 6.h),
              Text('Create your account', style: caption1.copyWith(color: secondary)),
              SizedBox(height: 10.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Container(
                  width: double.infinity,
                  height: 200.h,
                  color: Colors.grey,
                  child: Image.asset('assets/image_login.jpg', fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 21.h),
              AuthField(
                title: "Nama",
                hintText: "Masukkan nama",
                controller: nameController,
              ),
              AuthField(
                title: "No HP",
                hintText: "Masukkan Nomor HP",
                controller: noHpController,
              ),
              SizedBox(height: 16.h),
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
                controller: passController,
              ),
              SizedBox(height: 16.h),
              AuthField(
                title: "Confirm Password",
                hintText: "Masukkan konfirmasi password",
                isPassword: true,
                controller: confirmController,
              ),
              SizedBox(height: 21.h),
              CustomButton(
                title: isLoading ? '' : "Sign Up", // Hide title when loading
                onTap: () async {
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();
                  final password = passController.text.trim();
                  final noHp = noHpController.text.trim();
                  final confirmPassword = confirmController.text.trim();

                  if (password != confirmPassword) {
                    Get.snackbar("Error", "Passwords do not match",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }

                  setState(() {
                    isLoading = true; // Start loading
                  });

                  try {
                    // Use the AuthController to register the user
                    await authController.register(name, email, password, noHp);
                    Get.snackbar("Success", "Account created successfully!",
                        backgroundColor: Colors.green, colorText: Colors.white);
                    Get.offAll(() => const LoginPage());
                  } catch (e) {
                    Get.snackbar("Register Failed", e.toString(),
                        backgroundColor: Colors.redAccent, colorText: Colors.white);
                  } finally {
                    setState(() {
                      isLoading = false; // Stop loading
                    });
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : null, // Show loading indicator if isLoading is true
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: caption2.copyWith(color: Colors.grey)),
                  InkWell(
                    onTap: () => Get.to(() => const LoginPage()),
                    child: Text("Sign In", style: caption2.copyWith(color: primary, fontWeight: medium)),
                  ),
                ],
              ),
              SizedBox(height: 21.h),
            ],
          ),
        ),
      ),
    );
  }
}
