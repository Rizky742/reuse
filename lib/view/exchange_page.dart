import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/theme.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Exchange with Users',
          style: heading3.copyWith(color: primary),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: primary,
          tabs: const [
            Tab(text: 'Offers Made'),
            Tab(text: 'Offers Received'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOffersMade(),
          _buildOffersReceived(),
          _buildCompletedExchanges(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new exchange page
          Get.snackbar(
            'Info',
            'Halaman pertukaran baru sedang dalam pengembangan',
            backgroundColor: Colors.blue,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        backgroundColor: primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildOffersMade() {
    final List<Map<String, dynamic>> offersMade = [
      {
        'id': 'EXM12345',
        'date': '10 Jun 2023',
        'yourItem': 'Wooden Cutlery Set',
        'yourImage': 'https://images.tokopedia.net/img/cache/700/VqbcmM/2021/4/20/37627fe1-5b9f-4a52-a74d-dee357a0b271.png',
        'otherItem': 'Bamboo Straw Set',
        'otherImage': 'https://images.pexels.com/photos/4021976/pexels-photo-4021976.jpeg',
        'otherUser': 'Budi S.',
        'status': 'Pending',
        'note': 'Saya ingin menukar alat makan kayu saya dengan sedotan bambu Anda',
      },
    ];

    return offersMade.isEmpty
        ? _buildEmptyState('Belum ada tawaran dibuat', 'Anda belum membuat tawaran pertukaran dengan pengguna lain')
        : _buildExchangeList(offersMade, isOfferMade: true);
  }

  Widget _buildOffersReceived() {
    final List<Map<String, dynamic>> offersReceived = [
      {
        'id': 'EXR12333',
        'date': '8 Jun 2023',
        'yourItem': 'Reusable Coffee Cup',
        'yourImage': 'https://images.pexels.com/photos/8148098/pexels-photo-8148098.jpeg',
        'otherItem': 'Eco-friendly Water Bottle',
        'otherImage': 'https://ecoalf.com/cdn/shop/files/MCUACBOBOTFE0000S25-316_3_dfe3dea5-030b-4e51-9885-858d842b79e5.jpg?v=1740393444',
        'otherUser': 'Sinta R.',
        'status': 'Pending',
        'note': 'Botol saya masih baru, hanya dipakai 2 kali. Ingin menukar dengan coffee cup Anda',
      },
    ];

    return offersReceived.isEmpty
        ? _buildEmptyState('Belum ada tawaran masuk', 'Anda belum menerima tawaran pertukaran dari pengguna lain')
        : _buildExchangeList(offersReceived, isOfferMade: false);
  }

  Widget _buildCompletedExchanges() {
    final List<Map<String, dynamic>> completedExchanges = [
      {
        'id': 'EXC12111',
        'date': '15 Mei 2023',
        'yourItem': 'Reusable Bag',
        'yourImage': 'https://images.pexels.com/photos/5218021/pexels-photo-5218021.jpeg',
        'otherItem': 'Bamboo Toothbrush Set',
        'otherImage': 'https://images.pexels.com/photos/3737600/pexels-photo-3737600.jpeg',
        'otherUser': 'Arman W.',
        'status': 'Completed',
        'completedDate': '25 Mei 2023',
        'exchangeMethod': 'Bertemu langsung',
        'exchangeLocation': 'Taman Kota',
      },
      {
        'id': 'EXC11999',
        'date': '2 Mei 2023',
        'yourItem': 'Stainless Steel Lunch Box',
        'yourImage': 'https://prabhasteel.com/cdn/shop/files/RectangleLunchBoxTiffin01.jpg?v=1703149816',
        'otherItem': 'Recycled Notebook Set',
        'otherImage': 'https://images.pexels.com/photos/6690827/pexels-photo-6690827.jpeg',
        'otherUser': 'Diana T.',
        'status': 'Completed',
        'completedDate': '10 Mei 2023',
        'exchangeMethod': 'Dikirim via kurir',
        'rating': 5,
      },
    ];

    return completedExchanges.isEmpty
        ? _buildEmptyState('Belum ada pertukaran selesai', 'Anda belum memiliki pertukaran yang telah selesai dengan pengguna lain')
        : _buildExchangeList(completedExchanges, isOfferMade: null);
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.swap_horiz,
            size: 80.w,
            color: Colors.grey,
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: heading3.copyWith(color: Colors.grey[600]),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: body2.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              // Navigate to create new exchange offer
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text('Buat Tawaran Baru'),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeList(List<Map<String, dynamic>> exchanges, {bool? isOfferMade}) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: exchanges.length,
      itemBuilder: (context, index) {
        final exchange = exchanges[index];
        return _buildExchangeCard(exchange, isOfferMade: isOfferMade);
      },
    );
  }

  Widget _buildExchangeCard(Map<String, dynamic> exchange, {bool? isOfferMade}) {
    // Determine the status color
    Color statusColor;
    if (exchange['status'] == 'Pending') {
      statusColor = Colors.orange;
    } else if (exchange['status'] == 'Processing') {
      statusColor = Colors.blue;
    } else {
      statusColor = Colors.green;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exchange ID: ${exchange['id']}',
                      style: body2.copyWith(fontWeight: semiBold),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      exchange['date'],
                      style: caption1.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    exchange['status'],
                    style: caption2.copyWith(
                      color: Colors.white,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Exchange details
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Exchange partner
                Row(
                  children: [
                    Icon(Icons.person, size: 16.w, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text(
                      'Pengguna: ${exchange['otherUser']}',
                      style: body2.copyWith(fontWeight: semiBold),
                    ),
                  ],
                ),
                
                SizedBox(height: 16.h),
                
                // Items being exchanged
                Row(
                  children: [
                    // Your item
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              exchange['yourImage'],
                              width: 100.w,
                              height: 100.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Barang Anda',
                            style: caption2.copyWith(color: Colors.grey),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            exchange['yourItem'],
                            style: body2.copyWith(fontWeight: semiBold),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    
                    // Exchange icon
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Icon(
                        Icons.swap_horiz,
                        color: primary,
                        size: 24.w,
                      ),
                    ),
                    
                    // Other user's item
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              exchange['otherImage'],
                              width: 100.w,
                              height: 100.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Barang ${exchange['otherUser']}',
                            style: caption2.copyWith(color: Colors.grey),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            exchange['otherItem'],
                            style: body2.copyWith(fontWeight: semiBold),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 16.h),
                
                // Notes or additional info
                if (exchange['status'] == 'Pending' && exchange['note'] != null) ...[
                  Text(
                    'Catatan:',
                    style: body2.copyWith(fontWeight: semiBold),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      exchange['note'],
                      style: body2,
                    ),
                  ),
                ],
                
                // Completed exchange info
                if (exchange['status'] == 'Completed') ...[
                  SizedBox(height: 8.h),
                  
                  Row(
                    children: [
                      Icon(Icons.event_available, size: 16.w, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        'Selesai pada: ${exchange['completedDate']}',
                        style: caption2.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 8.h),
                  
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16.w, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        'Metode: ${exchange['exchangeMethod']}',
                        style: caption2.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  
                  if (exchange['exchangeLocation'] != null) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SizedBox(width: 20.w), // For alignment
                        Text(
                          'Lokasi: ${exchange['exchangeLocation']}',
                          style: caption2.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                  
                  if (exchange['rating'] != null) ...[
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16.w, color: Colors.amber),
                        SizedBox(width: 4.w),
                        Text(
                          'Rating: ${exchange['rating']}/5',
                          style: body2.copyWith(fontWeight: semiBold),
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),

          // Actions for pending exchanges
          if (exchange['status'] == 'Pending')
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // View details action
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Detail',
                        style: body2.copyWith(color: primary),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  
                  // If this is an offer we made
                  if (isOfferMade == true)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Cancel exchange
                          Get.dialog(
                            AlertDialog(
                              title: Text('Konfirmasi'),
                              content: Text('Apakah Anda yakin ingin membatalkan tawaran pertukaran ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text('Tidak'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    Get.snackbar(
                                      'Berhasil',
                                      'Tawaran pertukaran telah dibatalkan',
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: Text('Ya, Batalkan'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: const Text('Batalkan'),
                      ),
                    ),

                  // If this is an offer we received
                  if (isOfferMade == false)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Accept exchange
                                Get.dialog(
                                  AlertDialog(
                                    title: Text('Konfirmasi'),
                                    content: Text('Terima tawaran pertukaran ini?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text('Batal'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                          Get.snackbar(
                                            'Berhasil',
                                            'Tawaran pertukaran diterima',
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primary,
                                        ),
                                        child: Text('Terima'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text('Terima'),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Reject exchange
                                Get.dialog(
                                  AlertDialog(
                                    title: Text('Konfirmasi'),
                                    content: Text('Tolak tawaran pertukaran ini?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text('Batal'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                          Get.snackbar(
                                            'Info',
                                            'Tawaran pertukaran ditolak',
                                            backgroundColor: Colors.blue,
                                            colorText: Colors.white,
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: Text('Tolak'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text('Tolak'),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            
          // Actions for completed exchanges (leave review button)
          if (exchange['status'] == 'Completed' && exchange['rating'] == null)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
              child: ElevatedButton(
                onPressed: () {
                  // Show rating dialog
                  Get.dialog(
                    AlertDialog(
                      title: Text('Beri Rating'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Bagaimana pengalaman pertukaran Anda?'),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onPressed: () {
                                  Get.back();
                                  Get.snackbar(
                                    'Terima Kasih',
                                    'Rating telah diberikan',
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text('Batal'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: const Text('Beri Rating'),
              ),
            ),
        ],
      ),
    );
  }
} 