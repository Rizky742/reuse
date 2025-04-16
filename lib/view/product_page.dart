import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/theme.dart';
import 'package:get/get.dart';
import 'package:reuse/view/cart_page.dart';
import 'package:reuse/view/confirm_payment.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int? selectedSize;
  Color? selectedColor;

  final List<int> sizes = [39, 40, 41, 42, 43];
  final List<Color> colors = [
    Colors.pink,
    Colors.green,
    Colors.amber,
    Colors.black,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/main_logo.svg',
              width: 23.w,
              colorFilter: const ColorFilter.mode(primary, BlendMode.srcIn),
            ),
            SizedBox(width: 5.w),
            Text(
              "Reuse",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Container(
                  width: double.infinity,
                  height: 282.h,
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: Image.asset(
                    'assets/shoes.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Nama produk dan label zero plastic
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nike Jordan Used",
                    style: heading3.copyWith(color: primary),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    child: Text(
                      "Zero Plastic",
                      style: body3.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              // Rating dan harga
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < 4 ? Icons.star : Icons.star_border,
                        size: 20.w,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  Text("Rp 500.000", style: heading3),
                ],
              ),
              SizedBox(height: 10),

              // TabBar untuk Details dan Reviews
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: primary,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: primary,
                      tabs: const [
                        Tab(text: 'Details'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                    SizedBox(
                      height: 80.h,
                      child: const TabBarView(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "Lorem ipsum dolor sit amet consectetur. Bibendum posuere tortor magna dictum malesuada. Ac nec scelerisque nulla nullam. Tellus nulla diam odio est eget euismod."),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Belum ada ulasan untuk produk ini."),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Environment Impact
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Environment Impact", style: heading4),
              ),
              SizedBox(height: 4.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Plastic Saved: 50 grams"),
                  Text("Carbon Footprint: 2 kg CO2"),
                  Text("Energy Saved: 5"),
                ],
              ),

              SizedBox(height: 16.h),

              // Size Select
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Product Size", style: heading4),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 10,
                children: sizes.map((size) {
                  final isSelected = selectedSize == size;
                  return ChoiceChip(
                    label: Text(size.toString()),
                    selected: isSelected,
                    selectedColor: primary.withOpacity(0.2),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: isSelected ? primary : Colors.grey),
                    onSelected: (_) {
                      setState(() => selectedSize = size);
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 16.h),

              // Color Select
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Color Select", style: heading4),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 10,
                children: colors.map((color) {
                  final isSelected = selectedColor == color;
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedColor = color);
                    },
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? primary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: color,
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 24.h),

              // Add to Cart Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (selectedSize == null || selectedColor == null) {
                      Get.snackbar(
                        'Pilih Dulu',
                        'Silakan pilih ukuran dan warna produk.',
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.red,
                      );
                      return;
                    }

                    Get.to(() => const CartPage());
                  },
                  child: Text(
                    "Add to Cart",
                    style: body1.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
