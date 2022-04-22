import 'package:get/get.dart';
import 'package:week7_getx_upload/repository/upload_repository.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UploadRepository());
  }
}
