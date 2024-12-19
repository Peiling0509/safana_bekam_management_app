import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/home/profile_controller.dart';

class ProfileBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }

}