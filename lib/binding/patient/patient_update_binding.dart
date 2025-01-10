import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/patient/patient_controller.dart';
import 'package:safana_bekam_management_app/controller/treatment/treatment_controller.dart';

class UpdatePatientBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PatientController>(
      () => PatientController(),
    );
  }

}