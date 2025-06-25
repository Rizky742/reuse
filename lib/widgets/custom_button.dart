import 'package:flutter/material.dart';
import 'package:reuse/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Widget? child;  // Optional child widget for loading indicator or other widgets

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.child,  // Add child parameter
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(6.r),
        ),
        width: double.infinity,
        child: Center(
          child: child ??  // If child is provided, display it; otherwise, show the title text
              Text(
                title,
                style: body1.copyWith(color: Colors.white),
              ),
        ),
      ),
    );
  }
}
