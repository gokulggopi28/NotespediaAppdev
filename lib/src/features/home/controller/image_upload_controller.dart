import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notespedia/repositories/user_preferences.dart';

import '../../../../utils/constants/app_export.dart';

class ImageUploadController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var isLoading = false.obs;
  var uploadMessage = ''.obs;

  Future<void> captureAndUploadImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      isLoading(true);
      await uploadImage(File(photo.path));
      isLoading(false);
    } else {
      uploadMessage("No image selected");
    }
  }

  void _showLoading(bool show) {
    isLoading(show);
    if (show) {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
    } else {
      if (Get.isDialogOpen ?? false) Get.back();
    }
  }

  // New method to pick and upload an image from the gallery
  Future<void> pickAndUploadImageFromGallery() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      isLoading(true);
      await uploadImage(
          File(photo.path)); // Call uploadImage with the selected photo
      isLoading(false);
    } else {
      uploadMessage("No image selected");
    }
  }

  Future<void> uploadImage(File image) async {
    _showLoading(true); // Show loading indicator
    var formData = dio.FormData.fromMap({
      "user_id": UserPreferences.userId.toString(),
      "file": await dio.MultipartFile.fromFile(image.path,
          filename: image.path.split('/').last),
    });

    try {
      var response = await dio.Dio().post(
        'https://notespaedia.deienami.com/api/shelf/book_upload/',
        data: formData,
      );

      if (response.statusCode == 201) {
        uploadMessage("Image uploaded successfully");
        _showLoading(false); // Hide loading indicator
        // Show success Snackbar
        Get.snackbar(
          'Success',
          'Image Post added successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      uploadMessage("An error occurred while uploading the image: $e");
      _showLoading(false); // Hide loading indicator
      // Show failure Snackbar
      Get.snackbar(
        'Failure',
        'Image Posting Failed',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red, // Changed to red to indicate failure
        colorText: Colors.white,
      );
    }
  }
}
