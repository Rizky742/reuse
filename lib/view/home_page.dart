import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/cart_page.dart';
import 'package:reuse/view/product_page.dart';
import 'package:reuse/widgets/header_home.dart';
import 'package:reuse/widgets/product_card.dart';
import 'package:get/get.dart';

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

  // Halaman yang ditampilkan di BottomNavigationBar
  final List<Widget> _pages = [
    const HomeScreen(),     // Halaman Beranda
    const CartPage(), // Halaman Favorit
    const ProfileScreen(),  // Halaman Profil
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
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
         BottomNavigationBarItem(
  icon: SizedBox(
    height: 24, // atau sesuaikan dengan kebutuhanmu
    width: 24,
    child: SvgPicture.asset(
      'assets/cart_logo.svg',
      colorFilter: ColorFilter.mode(
        _selectedIndex == 1 ? primary : Colors.grey, // warnai sesuai status terpilih
        BlendMode.srcIn,
      ),
    ),
  ),
  label: 'Cart',
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
                      Get.to(() => const ProductPage());
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


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50.r,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?img=3', // ganti dengan image dari user
              ),
            ),
            SizedBox(height: 16.h),

            // User Info
            Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'user@example.com',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24.h),

            // Menu List
            Column(
              children: [
                buildProfileMenuItem(
                  icon: Icons.person,
                  title: 'Edit Profil',
                  onTap: () {
                    // Aksi edit profil
                  },
                ),
                buildProfileMenuItem(
                  icon: Icons.history,
                  title: 'Riwayat Pemesanan',
                  onTap: () {
                    // Aksi buka riwayat
                  },
                ),
                buildProfileMenuItem(
                  icon: Icons.settings,
                  title: 'Pengaturan',
                  onTap: () {
                    // Aksi pengaturan
                  },
                ),
                buildProfileMenuItem(
                  icon: Icons.logout,
                  title: 'Keluar',
                  onTap: () {
                    // Aksi logout
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        leading: Icon(icon, color: primary),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16.w),
        onTap: onTap,
      ),
    );
  }
}
