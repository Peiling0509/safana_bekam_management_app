import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/treatment/acupoint_controller.dart';

class RemarkBinding implements Bindings{
  @override
  void dependencies() {
     Get.lazyPut<AcupointController>(
      () => AcupointController(),
    );
  }

}