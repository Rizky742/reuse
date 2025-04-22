import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/exchange_page.dart';
import 'package:reuse/view/impact_page.dart';
import 'package:reuse/view/news_page.dart';
import 'package:reuse/view/product_page.dart';
import 'package:reuse/view/profile_page.dart';
import 'package:reuse/widgets/header_home.dart';
import 'package:reuse/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:reuse/services/auth_service.dart';
import 'package:reuse/models/product.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(), 
    const ExchangePage(), 
    const NewsPage(),
    const ImpactPage(),
    const ProfileScreen(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              width: 24,
              child: Icon(
                Icons.swap_horiz,
                color: _selectedIndex == 1 ? primary : Colors.grey,
              ),
            ),
            label: 'Exchange',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                'assets/impact.svg',
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 3 ? primary : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: 'Impact',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 28.h),
              const HeaderHome(),
              SizedBox(height: 28.h),
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
                      'assets/filter_logo.svg',
                      width: 20.w,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),
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
                        selected: false, // Menggunakan logika kategorinya
                        selectedColor: primary,
                        onSelected: (bool selected) {},
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        backgroundColor: primary,
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
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ProductPage(
                        product: Product(
                          name: product["title"],
                          image: product["imageUrl"],
                          price: product["price"],
                        ),
                      ));
                    },
                    child: ProductCard(
                      imageUrl: product["imageUrl"],
                      title: product["title"],
                      subtitle: product["subtitle"],
                      price: product["price"],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Halaman Favorit"));
  }
}
