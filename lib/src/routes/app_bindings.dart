import 'package:get/get.dart';
import 'package:simta1/src/providers/auth_provider.dart';
import 'package:simta1/src/providers/riwayat_provider.dart';
import 'package:simta1/src/providers/upload_file_provider.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<RiwayatController>(() => RiwayatController());
    Get.lazyPut<UploadController>(() => UploadController());
    // Get.put(AuthController());
  }
}

// class RiwayatBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<RiwayatController>(() => RiwayatController());
//     // Get.put(RiwayatController());
//   }
// }
