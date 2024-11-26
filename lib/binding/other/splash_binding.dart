import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/other/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}