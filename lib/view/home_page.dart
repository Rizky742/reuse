import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/widgets/header_home.dart';
import 'package:reuse/widgets/product_card.dart';

final List<String> categories = [
  "All",
  "Minuman",
  "Snack",
  "Meal",
  "Roti & Kue"
];

final List<Map<String, dynamic>> products = [
  {
    "imageUrl":
        "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg",
    "title": "Wood Spoon",
    "subtitle": "sdafdasf",
    "price": 900000.0
  },
  {
    "imageUrl":
        "https://images.pexels.com/photos/4066296/pexels-photo-4066296.jpeg",
    "title": "Wood Spoon",
    "subtitle": "sdafdasf",
    "price": 45000.0
  },
  {
    "imageUrl":
        "https://images.pexels.com/photos/1666063/pexels-photo-1666063.jpeg",
    "title": "Wood Spoon",
    "subtitle": "sdafdasf",
    "price": 20000.0
  },

];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedCategory = 0; // Default selected

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 28.h,
                ),
                const HeaderHome(),
                SizedBox(
                  height: 28.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search Food",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 16.w,
                          ),
                          prefixIcon: const Icon(Icons.search, color: primary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(color: primary),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: SvgPicture.asset(
                        'assets/filter_logo.svg', // Ganti dengan ikon filter SVG
                        width: 20.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 28.h,
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(categories[index]),
                          selected: selectedCategory == index,
                          selectedColor: primary,
                          onSelected: (bool selected) {
                            // Update state
                          },
                          labelStyle: TextStyle(
                            color: selectedCategory == index
                                ? Colors.white
                                : primary,
                          ),
                          backgroundColor: Colors.white,
                          shape: const StadiumBorder(
                            side: BorderSide(color: primary),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Menampilkan 2 produk per baris
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      imageUrl: product["imageUrl"],
                      title: product["title"],
                      subtitle: product["subtitle"],
                      price: product["price"],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
