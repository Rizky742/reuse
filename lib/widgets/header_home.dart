import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reuse/controllers/cart_controller.dart';
import 'package:reuse/theme.dart';
import 'package:get/get.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    cartController.getCart();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/main_logo.svg',
              width: 23.w,
              colorFilter: const ColorFilter.mode(primary, BlendMode.srcIn),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              "Reuse",
              style: heading2.copyWith(color: primary),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed('/cart'),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    'assets/cart_logo.svg',
                    width: 20.w,
                  ),
                  Positioned(
                    top: -7.h,
                    right: -3.w,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(100),
                          color: primary),
                      child: Center(
                        child: Obx(() {
                          return Text(
                            cartController.cart.length.toString(),
                            style: heading4.copyWith(
                              color: Colors.white,
                              fontSize: 10.sp,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
