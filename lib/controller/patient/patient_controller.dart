import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/data/model/patients/patients_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';
import 'package:safana_bekam_management_app/data/respository/patient_respository.dart';

class PatientController extends GetxController{
  final Rx<LoaderState> state = LoaderState.initial.obs;
  
  final repository = PatientsRepository();
  Rx<List<PatientsModel>> patients = Rx<List<PatientsModel>>([]);
  
  @override
  void onInit() {
    super.onInit();
    state.listen((v) {
      switch (v) {
        case LoaderState.empty:
        case LoaderState.initial:
        case LoaderState.loading:
          LoadingDialog.show();
          break;
        case LoaderState.loaded:
        case LoaderState.failure:
          LoadingDialog.hide();
          break;
      }
    });
    //loadPatients();
  }

  loadPatients()async{
    try {
      state.value = LoaderState.loading;
      final data = await repository.loadPatients();
      if(data.isEmpty) return state.value = LoaderState.empty;
      patients.value = data;
      state.value = LoaderState.loaded;
    } catch (e) {
      print(e.toString());
      state.value = LoaderState.failure;
    }
  }
}