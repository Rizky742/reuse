import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/auth_controller.dart'; // Kalau nanti dipakai
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/services/auth_service.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/edit_profile_page.dart';
import 'package:reuse/view/my_products.dart';
import 'package:reuse/view/order_history_page.dart';
import 'package:reuse/models/user_model.dart'; // Pastikan import model user

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  bool isLoading = true;
    final ProductController _productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    UserModel? loadedUser = await AuthService.getUserFromPrefs();
    setState(() {
      user = loadedUser;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Tampilkan loading spinner saat data belum siap
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                  radius: 50.r,
                  backgroundImage: const AssetImage('assets/user.png')),
              SizedBox(height: 16.h),

              // User Info
              Text(
                user?.name ?? 'User Name',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                user?.email ?? 'user@example.com',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24.h),

              // Menu List
              Column(
                children: [
                  buildProfileMenuItem(
                    icon: Icons.person,
                    title: 'Edit Profil',
                    onTap: () {
                      Get.to(() => const EditProfilePage());
                    },
                  ),
                  buildProfileMenuItem(
                    icon: Icons.inventory,
                    title: 'My Products',
                    onTap: () {
                      _productController.getAllMyProducts();
                       Get.to(() => MyProductsPage());
                    }
                  ),
                  buildProfileMenuItem(
                    icon: Icons.history,
                    title: 'Riwayat Pemesanan',
                    onTap: () {
                      Get.to(() => const OrderHistoryPage());
                    },
                  ),
                  // buildProfileMenuItem(
                  //   icon: Icons.settings,
                  //   title: 'Pengaturan',
                  //   onTap: () {
                  //     Get.snackbar(
                  //       'Info',
                  //       'Pengaturan sedang dalam pengembangan',
                  //       backgroundColor: Colors.blue,
                  //       colorText: Colors.white,
                  //       snackPosition: SnackPosition.BOTTOM,
                  //     );
                  //   },
                  // ),
                  buildProfileMenuItem(
                    icon: Icons.logout,
                    title: 'Keluar',
                    onTap: () async {
                      final result = await Get.dialog<bool>(
                        AlertDialog(
                          title: Text('Konfirmasi'),
                          content: Text('Apakah Anda yakin ingin keluar?'),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(result: false),
                              child: Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () => Get.back(result: true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                              ),
                              child: Text('Ya, Keluar'),
                            ),
                          ],
                        ),
                      );

                      if (result == true) {
                        await AuthService.clearUserPrefs();
                        // Jika kamu pakai controller logout, bisa panggil di sini
                        // await authController.logout();
                        Get.offAllNamed('/login');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        leading: Icon(icon, color: primary),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16.w),
        onTap: onTap,
      ),
    );
  }
}

Widget buildMyProduct({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.h),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      leading: Icon(icon, color: primary),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16.w),
      onTap: onTap,
    ),
  );
}
