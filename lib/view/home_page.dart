import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/controllers/exchange_controller.dart';
import 'package:reuse/controllers/impact_controller.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/exchange_page.dart';
import 'package:reuse/view/home_screen.dart';
import 'package:reuse/view/impact_page.dart';
import 'package:reuse/view/news_page.dart';
import 'package:reuse/view/product_page.dart';
import 'package:reuse/view/profile_page.dart';
import 'package:reuse/widgets/header_home.dart';
import 'package:reuse/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:reuse/models/product.dart';

final List<String> categories = [
  "All",
  "Minuman",
  "Snack",
  "Meal",
  "Roti & Kue"
];

class HomePage extends StatefulWidget {
  final int initialIndex;
  const HomePage({super.key, this.initialIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

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
    if (index == 0) {
      final productController = Get.find<ProductController>();
      productController.getAllProducts();
    }
    if (index == 1) {
      final exchangeController = Get.find<ExchangeController>();
      exchangeController.getOffersMade();
    }

    if (index == 3) {
      final impactController = Get.find<ImpactController>();
      impactController.getMyImpact();
    }
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

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Halaman Favorit"));
  }
}
