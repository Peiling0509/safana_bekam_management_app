import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/login/login_controller.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(), 
    );
  }


}