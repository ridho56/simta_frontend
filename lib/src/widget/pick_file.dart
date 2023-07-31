import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class PickAndUpload {
  Future<String> uploadFilePDF(Future controller, bool isLoading) async {
    try {
      isLoading = true;

      String file = await controller;

      return file;
    } catch (e) {
      Get.snackbar("Error", "$e");
      return '$e';
    } finally {
      isLoading = false;
    }
  }
}

Future<PlatformFile?> pickFileandUpload() async {
  const int maxFileSize = 5242880;

  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
  PlatformFile? file;
  if (result != null && result.files.isNotEmpty) {
    file = result.files.first;
    if (file.size > maxFileSize) {
      file = null;
      Get.snackbar("Error", "Ukuran file melebihi batasan maksimum (5 MB).");
    } else if (!file.name.toLowerCase().endsWith('.pdf')) {
      file = null;
      Get.snackbar("Error", "Hanya file PDF yang diperbolehkan");
    }
  } else {
    Get.snackbar("Error", "Digagalkan Oleh Penggguna");
  }
  return file;
}
