import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/theme.dart';

class AuthField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller; // 👈 Add this line

  const AuthField({
    super.key,
    required this.title,
    required this.hintText,
    this.isPassword = false,
    this.validator,
    this.controller, // 👈 Add this line
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
        SizedBox(height: 4.h),
        TextFormField(
          controller: controller, // 👈 Add this line
          style: caption2.copyWith(color: Colors.black),
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      // Optional: implement toggle visibility
                    },
                  )
                : null,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
