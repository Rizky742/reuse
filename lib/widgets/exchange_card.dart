import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/exchange_controller.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/utils/formatDate.dart';
import 'package:reuse/models/exchange_model.dart';
import 'package:reuse/widgets/dialogs/exchange_method_dialog.dart'; // Import modal terpisah

class ExchangeCard extends StatelessWidget {
  final ExchangeModel exchange;
  final bool? isOfferMade;
  final void Function(String phone, String message)?
      openWhatsApp; // callback WhatsApp

  const ExchangeCard({
    super.key,
    required this.exchange,
    this.isOfferMade,
    this.openWhatsApp,
  });

  @override
  Widget build(BuildContext context) {
    // Tentukan warna status
    Color statusColor;
    switch (exchange.status.toLowerCase()) {
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'processing':
        statusColor = Colors.blue;
        break;
      case 'completed':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.red;
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exchange ID',
                        style: body2.copyWith(fontWeight: semiBold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        exchange.id,
                        style: body2.copyWith(fontWeight: semiBold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        formatToLocalDate(exchange.exchangeDate),
                        style: caption1.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    exchange.status,
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
                      'Pengguna: ${exchange.receiver.name}',
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
                              'https://api.reuse.ngodingbareng.my.id${exchange.requesterProduct.imageUrl}',
                              width: 100.w,
                              height: 100.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100.w,
                                  height: 100.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey[600],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Barang Anda',
                            style: caption2.copyWith(color: Colors.grey),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            exchange.requesterProduct.name,
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
                              'https://api.reuse.ngodingbareng.my.id${exchange.receiverProduct.imageUrl}',
                              width: 100.w,
                              height: 100.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100.w,
                                  height: 100.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey[600],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Barang ${exchange.receiver.name}',
                            style: caption2.copyWith(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            exchange.receiverProduct.name,
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
                if (exchange.status.toLowerCase() == 'pending' &&
                    exchange.notes != null) ...[
                  Text(
                    'Catatan:',
                    style: body2.copyWith(fontWeight: semiBold),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      exchange.notes ?? "",
                      style: body2,
                    ),
                  ),
                ],

                if (exchange.status.toLowerCase() == 'pending') ...[
                  SizedBox(height: 16.h),
                  if (isOfferMade == true)
                    // Kalau tawaran yang kamu buat, tampilkan tombol Batalkan
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
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
                                    final exchangeController =
                                        Get.find<ExchangeController>();
                                    exchangeController.upateStatusOffer(
                                      id: exchange.id,
                                      status: 'cancelled',
                                    );
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text('Batalkan'),
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
                    )
                  else if (isOfferMade == false)
                    // Kalau tawaran yang diterima, tampilkan tombol Terima dan Tolak
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  title: const Text('Konfirmasi'),
                                  content: const Text(
                                      'Terima tawaran pertukaran ini?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text('Batal'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        final exchangeController =
                                            Get.find<ExchangeController>();
                                        exchangeController.upateStatusOffer(
                                            id: exchange.id,
                                            status: 'processing');
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
                            ),
                            child: const Text('Terima'),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  title: Text('Konfirmasi'),
                                  content:
                                      Text('Tolak tawaran pertukaran ini?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text('Batal'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        final exchangeController =
                                            Get.find<ExchangeController>();
                                        exchangeController.upateStatusOffer(
                                            id: exchange.id,
                                            status: 'cancelled');
                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: const Text('Tolak'),
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
                            child: const Text('Tolak'),
                          ),
                        ),
                      ],
                    ),
                ],

                // Completed exchange info
                if (exchange.status.toLowerCase() == 'completed') ...[
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.event_available,
                          size: 16.w, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        'Selesai pada: ${exchange.completedDate != null ? formatToLocalDate(exchange.completedDate!) : ""}',
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
                        'Metode: ${exchange.exchangeMethod ?? "-"}',
                        style: caption2.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  if (exchange.exchangeLocation != null) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SizedBox(width: 20.w),
                        Text(
                          'Lokasi: ${exchange.exchangeLocation}',
                          style: caption2.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
          
                ],

                // Tombol WhatsApp dan Selesai untuk status 'processing'
                if (exchange.status.toLowerCase() == 'processing' &&
                    openWhatsApp != null) ...[
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final phoneNumber =
                                exchange.receiver.phoneNumber ?? '';
                            final message =
                                "Halo ${exchange.receiver.name}, saya ingin konfirmasi pertukaran barang.";
                            openWhatsApp!(phoneNumber, message);
                          },
                          icon: Icon(Icons.chat),
                          label: Text('WhatsApp'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Panggil modal terpisah
                            ExchangeMethodDialog.show(
                              exchangeId: exchange.id,
                              onSuccess: () {
                                // Callback setelah berhasil (optional)
                                // Bisa digunakan untuk refresh data atau update UI
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text('Selesai'),
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
    );
  }
}
