import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reuse/theme.dart';

class ImpactPage extends StatelessWidget {
  const ImpactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Impact',
          style: heading3.copyWith(color: primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 18.5.w),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(16.w),
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Points',
                          style: body1.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '20+',
                          style: heading1.copyWith(color: Colors.white),
                        ),
                        Text(
                          'History Point',
                          style: body2.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/trophy.svg',
                      width: 60.w,
                      height: 60.w,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xff7667FB),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/waste.svg',
                              width: 80.w,
                              height: 80.w,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Waste Saved',
                              style: heading3.copyWith(color: Colors.white),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '500 m³',
                              style: heading1.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Limbah di TPA',
                              style: body2.copyWith(color: Colors.white70),
                            ),
                            SizedBox(height: 16.h),
                            SvgPicture.asset(
                              'assets/trophy.svg',
                              width: 20.w,
                              height: 20.w,
                              colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: const Color(0xffFB8F67),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/plastic.svg',
                                  width: 35.w,
                                  height: 50.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 8.w),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Plastic\nSaved',
                                        style: caption1.copyWith(color: Colors.white, fontWeight: semiBold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        '20',
                                        style: heading3.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Plastik',
                                        style: caption2.copyWith(color: Colors.white70),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Per Tahun',
                                        style: caption4.copyWith(color: Colors.white70),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: const Color(0xffFB6767),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/carbon_logo.svg',
                                  width: 40.w,
                                  height: 40.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 8.w),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Carbon\nSaved',
                                        style: caption1.copyWith(color: Colors.white, fontWeight: semiBold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        '20',
                                        style: heading3.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'KG',
                                        style: caption2.copyWith(color: Colors.white70),
                                      ),
                                      Text(
                                        'Per Tahun',
                                        style: caption4.copyWith(color: Colors.white70),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
