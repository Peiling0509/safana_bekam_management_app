import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/home/root_home_controller.dart';

class RootHomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RootHomeController>(
      () => RootHomeController(),
    );
  }

}