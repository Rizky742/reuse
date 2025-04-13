import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reuse/theme.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/main_logo.svg',
              width: 23.w,
              colorFilter:
                  const ColorFilter.mode(primary, BlendMode.srcIn),
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
            Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  'assets/whislist_logo.svg',
                  width: 20.w,
                ),
                Positioned(
                  top: -7.h,
                  right: -3.w,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadiusDirectional.circular(100),
                        color: primary),
                    child: Center(
                      child: Text(
                        "5",
                        style: heading4.copyWith(
                            color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Stack(
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
                        borderRadius:
                            BorderRadiusDirectional.circular(100),
                        color: primary),
                    child: Center(
                      child: Text(
                        "10",
                        style: heading4.copyWith(
                            color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
