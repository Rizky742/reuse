import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/controllers/exchange_controller.dart';

class ExchangeMethodDialog {
  static void show({
    required String exchangeId,
    VoidCallback? onSuccess,
  }) {
    final TextEditingController methodController = TextEditingController();
    final RxString selectedMethod = ''.obs;
    
    // Predefined methods untuk quick selection
    final List<String> predefinedMethods = [
      'COD (Cash on Delivery)',
      'Antar Jemput',
      'Kirim via Ekspedisi',
      'Bertemu di Tempat Umum',
      'Custom Method'
    ];

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan icon
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.swap_horiz,
                      color: Colors.blue,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Metode Pertukaran',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Pilih atau masukkan metode pertukaran',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20.h),
              
              // Quick selection buttons
              Text(
                'Pilih Cepat:',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              
              Obx(() => Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: predefinedMethods.map((method) {
                  return GestureDetector(
                    onTap: () {
                      if (method == 'Custom Method') {
                        selectedMethod.value = '';
                        methodController.clear();
                      } else {
                        selectedMethod.value = method;
                        methodController.text = method;
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: selectedMethod.value == method 
                            ? Colors.blue.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: selectedMethod.value == method 
                              ? Colors.blue
                              : Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        method,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: selectedMethod.value == method 
                              ? Colors.blue
                              : Colors.grey[700],
                          fontWeight: selectedMethod.value == method 
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )),
              
              SizedBox(height: 16.h),
              
              // Custom input field
              Text(
                'Atau masukkan sendiri:',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              
              TextField(
                controller: methodController,
                onChanged: (value) {
                  // Clear selected method when typing custom
                  if (selectedMethod.value != '' && value != selectedMethod.value) {
                    selectedMethod.value = '';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Contoh: COD di Mall, Antar ke alamat, dll',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.edit_outlined,
                    color: Colors.grey[400],
                    size: 20.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.05),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
                maxLines: 2,
                style: TextStyle(fontSize: 14.sp),
              ),
              
              SizedBox(height: 24.h),
              
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Batal',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        final metode = methodController.text.trim();
                        if (metode.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Metode tidak boleh kosong',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            margin: EdgeInsets.all(16.w),
                            borderRadius: 12.r,
                            icon: Icon(Icons.error_outline, color: Colors.white),
                            duration: Duration(seconds: 3),
                          );
                          return;
                        }

                        // Panggil controller update status jadi completed dan simpan metode
                        final exchangeController = Get.find<ExchangeController>();
                        exchangeController.upateStatusOffer(
                          id: exchangeId,
                          status: 'completed',
                          metode: metode,
                        );

                        Get.back();
                        
                        // Tampilkan success message
                        Get.snackbar(
                          'Sukses',
                          'Status berhasil diperbarui menjadi selesai',
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: EdgeInsets.all(16.w),
                          borderRadius: 12.r,
                          icon: Icon(Icons.check_circle_outline, color: Colors.white),
                          duration: Duration(seconds: 3),
                        );

                        // Callback untuk refresh atau update UI
                        if (onSuccess != null) {
                          onSuccess();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, size: 18.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Selesaikan',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}