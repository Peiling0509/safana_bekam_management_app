import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/treatment/treatment_controller.dart';

class TreatmentBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TreatmentController>(
      () => TreatmentController(),
    );
  
  }

}