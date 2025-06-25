import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reuse/controllers/product_controller.dart';
import 'package:reuse/models/product_model.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/my_products.dart';
import 'package:reuse/widgets/custom_textfield.dart';

class AddProductPage extends StatefulWidget {
  final ProductModel? product; // null berarti mode add

  const AddProductPage({super.key, this.product});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final ProductController _productController = Get.find<ProductController>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _plasticSavedController = TextEditingController();
  final TextEditingController _carbonSavedController = TextEditingController();
  final TextEditingController _wasteSavedController = TextEditingController();
  XFile? _imageFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _descController.text = widget.product!.description;
      _plasticSavedController.text = widget.product!.plasticSaved.toString();
      _carbonSavedController.text = widget.product!.carbonSaved.toString();
      _wasteSavedController.text = widget.product!.wasteSaved;
      // image tidak bisa di-prefill karena File tidak bisa dari URL langsung
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    
    // Fix: Check for image requirement properly
    if (widget.product == null && _imageFile == null) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (widget.product != null) {
        // Edit mode - call update method
        await _productController.updateProduct(
          id: widget.product!.id,
          name: _nameController.text,
          price: int.parse(_priceController.text),
          description: _descController.text,
          plasticSaved: double.parse(_plasticSavedController.text),
          carbonSaved: double.parse(_carbonSavedController.text),
          wasteSaved: double.parse(_wasteSavedController.text),
          imageFile: _imageFile, // Can be null if no new image selected
        );
        print('test');
      } else {
        // Add mode
        await _productController.createProduct(
          name: _nameController.text,
          price: int.parse(_priceController.text),
          description: _descController.text,
          plasticSaved: double.parse(_plasticSavedController.text),
          carbonSaved: double.parse(_carbonSavedController.text),
          wasteSaved: double.parse(_wasteSavedController.text),
          imageFile: _imageFile!,
        );
      }

      _productController.getAllMyProducts();
      Get.off(() => MyProductsPage());
      Get.snackbar(
        'Success',
        widget.product != null 
            ? 'Product updated successfully'
            : 'Product added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        widget.product != null 
            ? 'Failed to update product: ${e.toString()}'
            : 'Failed to add product: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildImageWidget() {
    // Fix: Better image display logic
    if (_imageFile != null) {
      // Show newly selected image
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.file(
          File(_imageFile!.path),
          fit: BoxFit.cover,
        ),
      );
    } else if (widget.product != null && widget.product!.imageUrl.isNotEmpty) {
      // Show existing product image
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.network(
          'https://api.reuse.ngodingbareng.my.id${widget.product!.imageUrl}',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image, size: 40.w, color: Colors.grey),
                SizedBox(height: 8.h),
                Text(
                  'Failed to load image',
                  style: body2.copyWith(color: Colors.grey),
                ),
              ],
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      );
    } else {
      // Show placeholder for image selection
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo, size: 40.w, color: Colors.grey),
          SizedBox(height: 8.h),
          Text(
            'Add Photo',
            style: body2.copyWith(color: Colors.grey),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _plasticSavedController.dispose();
    _carbonSavedController.dispose();
    _wasteSavedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fix: Safe debug print
    if (widget.product != null) {
      print('Product image URL: ${widget.product!.imageUrl}');
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product != null ? 'Edit Product' : 'Add New Product',
          style: heading2.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Upload
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 150.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _buildImageWidget(),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'Tap to ${_imageFile != null || (widget.product != null && widget.product!.imageUrl.isNotEmpty) ? 'change' : 'select'} image',
                  style: body2.copyWith(color: Colors.grey),
                ),
              ),
              SizedBox(height: 24.h),

              // Product Name
              Text('Product Name',
                  style: body1.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter product name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Price
              Text('Price', style: body1.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _priceController,
                hintText: 'Enter price',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter valid number';
                  }
                  return null;
                },
                prefixText: 'Rp ',
              ),
              SizedBox(height: 16.h),

              // Description
              Text('Description',
                  style: body1.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _descController,
                hintText: 'Enter product description',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Environmental Impact Section
              Text('Environmental Impact', style: heading4),
              SizedBox(height: 12.h),

              // Plastic Saved
              Text('Plastic Saved (grams)', style: body1),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _plasticSavedController,
                hintText: 'Enter amount',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter valid number';
                  }
                  return null;
                },
                suffixText: 'g',
              ),
              SizedBox(height: 12.h),

              // Carbon Saved
              Text('Carbon Footprint Saved (kg CO2)', style: body1),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _carbonSavedController,
                hintText: 'Enter amount',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter valid number';
                  }
                  return null;
                },
                suffixText: 'kg',
              ),
              SizedBox(height: 12.h),

              // Waste Saved
              Text('Waste Saved', style: body1),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: _wasteSavedController,
                hintText: 'Enter description',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          widget.product != null
                              ? "Edit Product"
                              : 'Add Product',
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