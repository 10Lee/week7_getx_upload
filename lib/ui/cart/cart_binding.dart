import 'package:get/get.dart';
import 'package:week7_getx_upload/ui/cart/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
    // TODO: implement dependencies
  }
}
