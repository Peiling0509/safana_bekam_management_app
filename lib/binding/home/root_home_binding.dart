import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/home/dashboard_controller.dart';
import 'package:safana_bekam_management_app/controller/home/root_home_controller.dart';
import 'package:safana_bekam_management_app/controller/patient/patient_controller.dart';

class RootHomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RootHomeController>(
      () => RootHomeController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<PatientController>(
      () => PatientController(),
    );
  }

}