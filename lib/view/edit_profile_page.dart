import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/models/user_model.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/services/auth_service.dart'; // pastikan ini ada dan benar

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controller harus nullable karena nanti diisi setelah data user didapat
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _addressController;


  @override
  void dispose() {
    _nameController?.dispose();
    _emailController?.dispose();
    _phoneController?.dispose();
    _addressController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: AuthService.getUserFromPrefs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final user = snapshot.data;
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('User tidak ditemukan')),
          );
        }

        // Inisialisasi controller jika belum dibuat
        _nameController ??= TextEditingController(text: user.name );
        _emailController ??= TextEditingController(text: user.email );
        _phoneController ??= TextEditingController(text: user.phoneNumber );
        _addressController ??= TextEditingController(text: user.address);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profil',
              style: heading3.copyWith(color: primary),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60.r,
                          backgroundImage: const NetworkImage(
                            'https://i.pravatar.cc/150?img=3',
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: primary,
                              shape: BoxShape.circle,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Logic to change profile picture
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Ganti Foto Profil'),
                                    content: const Text('Pilih sumber foto'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Kamera'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Galeri'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  _buildFormField('Nama Lengkap', 'Masukkan nama lengkap', _nameController!, Icons.person),
                  SizedBox(height: 16.h),
                  _buildFormField('Email', 'Masukkan email', _emailController!, Icons.email),
                  SizedBox(height: 16.h),
                  _buildFormField('Nomor Telepon', 'Masukkan nomor telepon', _phoneController!, Icons.phone),
                  SizedBox(height: 16.h),
                  _buildFormField('Alamat', 'Masukkan alamat lengkap', _addressController!, Icons.location_on, maxLines: 3),
                  SizedBox(height: 32.h),
                  ElevatedButton(
                    onPressed: () {
                      // Simpan data (bisa panggil API update user atau simpan di local)
                      // Untuk sekarang, hanya tampil snackbar dan kembali
                      Get.back();
                      Get.snackbar(
                        'Sukses',
                        'Profil berhasil diperbarui',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Simpan Perubahan',
                      style: body1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormField(
    String label,
    String hint,
    TextEditingController controller,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: body2.copyWith(fontWeight: semiBold),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: primary),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
        ),
      ],
    );
  }
}