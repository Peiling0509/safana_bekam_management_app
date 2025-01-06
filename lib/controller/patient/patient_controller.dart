import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/data/model/patients/patients_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';
import 'package:safana_bekam_management_app/data/respository/patient_respository.dart';

class PatientController extends GetxController{
  final Rx<LoaderState> state = LoaderState.initial.obs;
  
  final repository = PatientsRepository();
  Rx<List<PatientsModel>> patients = Rx<List<PatientsModel>>([]);

   Rx<PatientsModel> currentPatient = PatientsModel(
    name: '',
    myKad: '',
    gender: '',
    ethnicity: '',
    mobileNo: '',
    email: '',
    postcode: '',
    state: '',
    address: '',
    occupation: '',
    medicalHistory: [],
  ).obs;

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

  void updatePatientInfo({
    String? name,
    String? myKad,
    String? gender,
    String? ethnicity,
    String? mobileNo,
    String? email,
    String? postcode,
    String? state,
    String? address,
    String? occupation,
  }) {
    currentPatient.update((patient) {
      if (patient != null) {
        if (name != null) patient.name = name;
        if (myKad != null) patient.myKad = myKad;
        if (gender != null) patient.gender = gender;
        if (ethnicity != null) patient.ethnicity = ethnicity;
        if (mobileNo != null) patient.mobileNo = mobileNo;
        if (email != null) patient.email = email;
        if (postcode != null) patient.postcode = postcode;
        if (state != null) patient.state = state;
        if (address != null) patient.address = address;
        if (occupation != null) patient.occupation = occupation;
      }
    });
  }

  Future<void> submitPatient() async {
    try {
      await repository.submitPatient(currentPatient.value);
      Get.snackbar("Success", "Patient added successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to add patient");
    }
  }

  void addMedicalHistory(String condition, String medicine) {
    currentPatient.value.medicalHistory.add(MedicalHistoryModel(
      condition: condition,
      medicine: medicine,
    ));
    currentPatient.refresh();
  }

  void removeMedicalHistory(int index) {
    currentPatient.value.medicalHistory.removeAt(index);
    currentPatient.refresh();
  }
}