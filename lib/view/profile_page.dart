import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/services/auth_service.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/edit_profile_page.dart';
import 'package:reuse/view/order_history_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50.r,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?img=3', // ganti dengan image dari user
              ),
            ),
            SizedBox(height: 16.h),

            // User Info
            Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'user@example.com',
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
                    // Navigate to edit profile page
                    Get.to(() => EditProfilePage());
                  },
                ),
                buildProfileMenuItem(
                  icon: Icons.history,
                  title: 'Riwayat Pemesanan',
                  onTap: () {
                    // Navigate to order history page
                    Get.to(() => OrderHistoryPage());
                  },
                ),
                buildProfileMenuItem(
                  icon: Icons.settings,
                  title: 'Pengaturan',
                  onTap: () {
                    // Aksi pengaturan
                    Get.snackbar(
                      'Info',
                      'Pengaturan sedang dalam pengembangan',
                      backgroundColor: Colors.blue,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
                buildProfileMenuItem(
                  icon: Icons.logout,
                  title: 'Keluar',
                  onTap: () async {
                    // Show confirmation dialog
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
                      await AuthService.logout();
                      Get.offAllNamed('/login');
                    }
                  },
                ),
              ],
            ),
          ],
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
