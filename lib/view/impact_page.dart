import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reuse/controllers/impact_controller.dart';
import 'package:reuse/theme.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ImpactPage extends StatelessWidget {
  const ImpactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ImpactController impactController = Get.find<ImpactController>();
    // impactController.getMyImpact();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Your Impact',
          style: heading3.copyWith(
            color: primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => impactController.getMyImpact(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Obx(
              () {
                if (impactController.isLoading.value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      shimmerHeroPointCard(),
                      SizedBox(height: 32.h),
                      shimmerWasteCard(),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(child: shimmerImpactSmallCard()),
                          SizedBox(width: 16.w),
                          Expanded(child: shimmerImpactSmallCard()),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      shimmerDonationCard(),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
        
                    // Hero Points Card
                    // Container(
                    //   padding: EdgeInsets.all(24.w),
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       colors: [primary, primary.withOpacity(0.8)],
                    //       begin: Alignment.topLeft,
                    //       end: Alignment.bottomRight,
                    //     ),
                    //     borderRadius: BorderRadius.circular(20.r),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: primary.withOpacity(0.3),
                    //         blurRadius: 20,
                    //         offset: const Offset(0, 8),
                    //       ),
                    //     ],
                    //   ),
                    //   width: double.infinity,
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 2,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               padding: EdgeInsets.symmetric(
                    //                   horizontal: 12.w, vertical: 6.h),
                    //               decoration: BoxDecoration(
                    //                 color: Colors.white.withOpacity(0.2),
                    //                 borderRadius: BorderRadius.circular(20.r),
                    //               ),
                    //               child: Text(
                    //                 'TOTAL EARNED',
                    //                 style: caption2.copyWith(
                    //                   color: Colors.white70,
                    //                   fontWeight: FontWeight.w600,
                    //                   letterSpacing: 1.2,
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(height: 8.h),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.end,
                    //               children: [
                    //                 Text(
                    //                   '20',
                    //                   style: TextStyle(
                    //                     fontSize: 48.sp,
                    //                     fontWeight: FontWeight.w800,
                    //                     color: Colors.white,
                    //                     height: 1,
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding:
                    //                       EdgeInsets.only(bottom: 8.h, left: 4.w),
                    //                   child: Text(
                    //                     '+',
                    //                     style: TextStyle(
                    //                       fontSize: 24.sp,
                    //                       fontWeight: FontWeight.w600,
                    //                       color: Colors.white70,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Text(
                    //               'Impact Points',
                    //               style: body2.copyWith(
                    //                 color: Colors.white.withOpacity(0.9),
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Container(
                    //           padding: EdgeInsets.all(16.w),
                    //           decoration: BoxDecoration(
                    //             color: Colors.white.withOpacity(0.15),
                    //             borderRadius: BorderRadius.circular(16.r),
                    //           ),
                    //           child: SvgPicture.asset(
                    //             'assets/trophy.svg',
                    //             width: 64.w,
                    //             height: 64.w,
                    //             colorFilter: ColorFilter.mode(
                    //               Colors.white.withOpacity(0.9),
                    //               BlendMode.srcIn,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
        
                    // SizedBox(height: 32.h),
        
                    // // Section Header
                    // Text(
                    //   'Environmental Impact',
                    //   style: heading3.copyWith(
                    //     color: Colors.black87,
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
        
                    SizedBox(height: 16.h),
        
                    // Large Waste Card - Full Width
                    Container(
                      height: 200.h,
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff8B7CF6), Color(0xff7C3AED)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff7C3AED).withOpacity(0.25),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: SvgPicture.asset(
                                  'assets/waste.svg',
                                  width: 32.w,
                                  height: 32.w,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                'Waste Diverted',
                                style: heading3.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                impactController.impact?.wasteSaved.toString() ?? "0",
                                style: TextStyle(
                                  fontSize: 48.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'cubic meters',
                                style: body1.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'from landfills',
                                style: body2.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
        
                    SizedBox(height: 16.h),
        
                    // Bottom Row - Plastic & Carbon Cards
                    Row(
                      children: [
                        // Plastic Card
                        Expanded(
                          child: Container(
                            height: 160.h,
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xffF97316), Color(0xffEA580C)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xffF97316).withOpacity(0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/plastic.svg',
                                        width: 24.w,
                                        height: 24.w,
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        'Plastic Saved',
                                        style: body2.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      impactController.impact?.plasticSaved.toString() ?? '0',
                                      style: TextStyle(
                                        fontSize: 36.sp,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'items/year',
                                      style: body2.copyWith(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
        
                        SizedBox(width: 16.w),
        
                        // Carbon Card
                        Expanded(
                          child: Container(
                            height: 160.h,
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xffEF4444), Color(0xffDC2626)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xffEF4444).withOpacity(0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/carbon.svg',
                                        width: 24.w,
                                        height: 24.w,
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        'Carbon Saved',
                                        style: body2.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      impactController.impact?.carbonSaved.toString() ?? '0',
                                      style: TextStyle(
                                        fontSize: 36.sp,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'kg/year',
                                      style: body2.copyWith(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
        
                    SizedBox(height: 32.h),
        
                    // Achievement Badge
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.eco_outlined,
                              color: primary,
                              size: 24.w,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Eco Warrior Badge Earned!',
                                  style: body1.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Keep up the great work protecting our environment',
                                  style: caption1.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                            size: 20.w,
                          ),
                        ],
                      ),
                    ),
        
                    SizedBox(height: 24.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget shimmerHeroPointCard() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: 160.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
    ),
  );
}

Widget shimmerWasteCard() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
    ),
  );
}

Widget shimmerImpactSmallCard() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: 160.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
    ),
  );
}

Widget shimmerDonationCard() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
      ),
    ),
  );
}
