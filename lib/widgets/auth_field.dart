import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/theme.dart';

class AuthField extends StatelessWidget {
  final String title; // Judul field (misal: "Email" atau "Password")
  final String hintText; // Teks petunjuk (misal: "Masukkan email Anda")
  final bool isPassword; // Apakah field ini untuk password?
  final String? Function(String?)? validator; // Fungsi validasi

  const AuthField({
    super.key,
    required this.title,
    required this.hintText,
    this.isPassword = false, // Default false (untuk email)
    this.validator, // Validator opsional
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: heading3.copyWith(color: Colors.black, fontWeight: medium),
        ),
        SizedBox(
          height: 4.h,
        ),
        TextFormField(
          style: caption2.copyWith(color: Colors.black),
          obscureText: isPassword, // Menyembunyikan teks jika ini adalah password
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            // Tambahkan ikon mata untuk password (opsional)
            suffixIcon: isPassword
                ? IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      // Tambahkan logika untuk toggle visibility
                    },
                  )
                : null,
          ),
          validator: validator, // Validator untuk validasi input
        ),
      ],
    );
  }
}