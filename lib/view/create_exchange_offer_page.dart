import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/exchange_controller.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/models/product_model.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/utils/formatPrice.dart';
import 'package:shimmer/shimmer.dart';

class CreateExchangeOfferPage extends StatefulWidget {
  final ProductModel product;
  final int? selectedSize;
  final Color? selectedColor;

  const CreateExchangeOfferPage({
    super.key,
    required this.product,
    this.selectedSize,
    this.selectedColor,
  });

  @override
  State<CreateExchangeOfferPage> createState() =>
      _CreateExchangeOfferPageState();
}

class _CreateExchangeOfferPageState extends State<CreateExchangeOfferPage> {
  final TextEditingController _noteController = TextEditingController();
  final ProductController _productController = Get.find<ProductController>();
  final ExchangeController exchangeController = Get.find<ExchangeController>();
  String? _selectedItemForExchange;

  // Contoh daftar item pengguna untuk ditukar
  final List<Map<String, dynamic>> _userItems = [
    {
      'id': '1',
      'name': 'Sepatu ASUS TERO',
      'image':
          'https://www.inasport.co.id/wp-content/uploads/2020/12/BW-50.jpg',
      'condition': 'Bekas - Bagus',
      'estimatedValue': 'Rp 350.000',
    },
    {
      'id': '2',
      'name': 'Botol Air Reusable Evo',
      'image':
          'https://ecoalf.com/cdn/shop/files/MCUACBOBOTFE0000S25-316_3_dfe3dea5-030b-4e51-9885-858d842b79e5.jpg?v=1740393444',
      'condition': 'Bekas - Sangat Bagus',
      'estimatedValue': 'Rp 120.000',
    },
    {
      'id': '3',
      'name': 'Lunch Box Stainless',
      'image':
          'https://prabhasteel.com/cdn/shop/files/RectangleLunchBoxTiffin01.jpg?v=1703149816',
      'condition': 'Baru',
      'estimatedValue': 'Rp 180.000',
    },
  ];
  Future<void> _loadProducts() async {
    try {
      await _productController.getAllMyProducts();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load products',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void initState() {
    _loadProducts();
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Widget _buildShimmerGrid() {
    return Column(
      children: List.generate(3, (index) => _buildShimmerCard()),
    );
  }

  Widget _buildShimmerCard() {
  return Padding(
    padding: EdgeInsets.only(bottom: 16.h),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 14.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 12.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buat Tawaran Pertukaran',
          style: heading3.copyWith(color: primary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product yang ingin ditukar
              Text(
                'Produk Yang Anda Inginkan',
                style: heading4.copyWith(fontWeight: semiBold),
              ),
              SizedBox(height: 12.h),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                      child: Image.network(
                        'https://api.reuse.ngodingbareng.my.id${widget.product.imageUrl}',
                        width: 100.w,
                        height: 100.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: body1.copyWith(fontWeight: semiBold),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            formatPrice(widget.product.price),
                            style: body2.copyWith(
                                color: primary, fontWeight: semiBold),
                          ),
                          if (widget.selectedSize != null) ...[
                            SizedBox(height: 4.h),
                            Text(
                              'Ukuran: ${widget.selectedSize}',
                              style: caption1,
                            ),
                          ],
                          if (widget.selectedColor != null) ...[
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Text(
                                  'Warna: ',
                                  style: caption1,
                                ),
                                Container(
                                  width: 16.w,
                                  height: 16.w,
                                  decoration: BoxDecoration(
                                    color: widget.selectedColor,
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Pilih item yang akan ditukar
              Text(
                'Pilih Item Anda yang Akan Ditukar',
                style: heading4.copyWith(fontWeight: semiBold),
              ),
              SizedBox(height: 12.h),
              Obx(
                () {
                  if (_productController.isLoading.value) {
                    return _buildShimmerGrid();
                  }
                  return Column(
                    children: _productController.myProducts
                        .map((item) => _buildItemSelectionCard(item))
                        .toList(),
                  );
                },
              ),

              SizedBox(height: 24.h),

              // Tambah item baru
              GestureDetector(
                onTap: () {
                  // Aksi untuk menambah item baru
                  Get.snackbar(
                    'Info',
                    'Fitur tambah item baru sedang dalam pengembangan',
                    backgroundColor: Colors.blue,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: primary.withOpacity(0.5), width: 1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_circle_outline, color: primary),
                      SizedBox(width: 8.w),
                      Text(
                        'Tambahkan Item Baru',
                        style: body2.copyWith(color: primary),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Catatan untuk pemilik produk
              Text(
                'Catatan untuk Pemilik',
                style: heading4.copyWith(fontWeight: semiBold),
              ),
              SizedBox(height: 8.h),

              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tambahkan catatan tentang penawaran Anda...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: primary),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(16.w),
                ),
              ),

              SizedBox(height: 32.h),

              // Tombol kirim tawaran
              ElevatedButton(
                onPressed: _selectedItemForExchange == null
                    ? null
                    : () {
                        // Proses pengiriman tawaran
                        Get.dialog(
                          AlertDialog(
                            title: const Text('Konfirmasi'),
                            content:
                                const Text('Kirim tawaran pertukaran ini?'),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Batal'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  exchangeController.createOffer(receiverId: widget.product.user.id, receiverProductId: _selectedItemForExchange!, requesterProductId: widget.product.id, notes: _noteController.text);
                                
                                  Get.snackbar(
                                    'Berhasil',
                                    'Tawaran pertukaran telah dikirim!',
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primary,
                                ),
                                child: const Text('Kirim'),
                              ),
                            ],
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade400,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Kirim Tawaran Pertukaran',
                  style: body1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemSelectionCard(ProductModel item) {
    final bool isSelected = _selectedItemForExchange == item.id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemForExchange = item.id;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: Image.network(
                'https://api.reuse.ngodingbareng.my.id${item.imageUrl}',
                width: 100.w,
                height: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: body1.copyWith(fontWeight: semiBold),
                  ),
                  // SizedBox(height: 4.h),
                  // Text(
                  //   'Kondisi: ${item['condition']}',
                  //   style: caption1,
                  // ),
                  SizedBox(height: 4.h),
                  Text(
                    'Nilai Perkiraan: ${formatPrice(item.price)}',
                    style: body2.copyWith(color: primary, fontWeight: semiBold),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: item.id,
              groupValue: _selectedItemForExchange,
              activeColor: primary,
              onChanged: (value) {
                setState(() {
                  _selectedItemForExchange = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
