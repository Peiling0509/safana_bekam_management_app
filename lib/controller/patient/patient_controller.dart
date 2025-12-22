import 'package:get/get.dart';

import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/components/toast.dart';
import 'package:safana_bekam_management_app/data/model/patients/medical_history_model.dart';
import 'package:safana_bekam_management_app/data/model/patients/patients_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';
import 'package:safana_bekam_management_app/data/respository/patient_respository.dart';

class PatientController extends GetxController {
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

  List<PatientsModel> dummyPatients = [
    PatientsModel(
      id: 1,
      name: "John Doe",
      myKad: "900101-14-5678",
      gender: "Male",
      ethnicity: "Malay",
      mobileNo: "0123456789",
      email: "john.doe@example.com",
      postcode: "12345",
      state: "Selangor",
      address: "123 Jalan Mawar, Shah Alam",
      occupation: "Engineer",
      medicalHistory: [
        MedicalHistoryModel(condition: "Diabetes", medicine: "Metformin"),
        MedicalHistoryModel(condition: "Hypertension", medicine: "Lisinopril")
      ],

    ),
    PatientsModel(
      id: 2,
      name: "Jane Smith",
      myKad: "950202-10-9876",
      gender: "Female",
      ethnicity: "Chinese",
      mobileNo: "0129876543",
      email: "jane.smith@example.com",
      postcode: "56789",
      state: "Penang",
      address: "45 Jalan Teratai, George Town",
      occupation: "Teacher",
      medicalHistory: [
        MedicalHistoryModel(condition: "Diabetes", medicine: "Metformin"),
        MedicalHistoryModel(condition: "Hypertension", medicine: "Lisinopril")
      ],
    ),
    PatientsModel(
      id: 3,
      name: "Ali bin Ahmad",
      myKad: "880303-08-3456",
      gender: "Male",
      ethnicity: "Malay",
      mobileNo: "0134567890",
      email: "ali.ahmad@example.com",
      postcode: "34567",
      state: "Johor",
      address: "67 Jalan Cempaka, Johor Bahru",
      occupation: "Doctor",
      medicalHistory: [
        MedicalHistoryModel(condition: "Diabetes", medicine: "Metformin"),
        MedicalHistoryModel(condition: "Hypertension", medicine: "Lisinopril")
      ],
    ),
    PatientsModel(
      id: 4,
      name: "Siti Nurhaliza",
      myKad: "870404-12-2345",
      gender: "Female",
      ethnicity: "Malay",
      mobileNo: "0145678901",
      email: "siti.nurhaliza@example.com",
      postcode: "67890",
      state: "Kuala Lumpur",
      address: "12 Jalan Anggerik, KL",
      occupation: "Singer",
      medicalHistory: [
        MedicalHistoryModel(condition: "Diabetes", medicine: "Metformin"),
        MedicalHistoryModel(condition: "Hypertension", medicine: "Lisinopril")
      ],
    ),
    PatientsModel(
      id: 5,
      name: "Michael Tan",
      myKad: "930505-16-4567",
      gender: "Male",
      ethnicity: "Chinese",
      mobileNo: "0156789012",
      email: "michael.tan@example.com",
      postcode: "11223",
      state: "Malacca",
      address: "88 Jalan Dahlia, Melaka",
      occupation: "Chef",
      medicalHistory: [
        MedicalHistoryModel(condition: "Diabetes", medicine: "Metformin"),
        MedicalHistoryModel(condition: "Hypertension", medicine: "Lisinopril")
      ],
    ),
    PatientsModel(
      id: 6,
      name: "Ramesh Kumar",
      myKad: "910606-11-7890",
      gender: "Male",
      ethnicity: "Indian",
      mobileNo: "0167890123",
      email: "ramesh.kumar@example.com",
      postcode: "44556",
      state: "Perak",
      address: "34 Jalan Melur, Ipoh",
      occupation: "IT Consultant",
      medicalHistory: [
        MedicalHistoryModel(condition: "Diabetes", medicine: "Metformin"),
        MedicalHistoryModel(condition: "Hypertension", medicine: "Lisinopril")
      ],
    ),
    PatientsModel(
      id: 7,
      name: "Aminah Binti Yusuf",
      myKad: "920707-10-2345",
      gender: "Female",
      ethnicity: "Malay",
      mobileNo: "0178901234",
      email: "aminah.yusuf@example.com",
      postcode: "22334",
      state: "Sabah",
      address: "56 Jalan Kenanga, Kota Kinabalu",
      occupation: "Accountant",
      medicalHistory: [
        MedicalHistoryModel(condition: "Diabetes", medicine: "Metformin"),
        MedicalHistoryModel(condition: "Hypertension", medicine: "Lisinopril")
      ],
    ),
    PatientsModel(
      id: 8,
      name: "Emily Wong",
      myKad: "940808-14-3456",
      gender: "Female",
      ethnicity: "Chinese",
      mobileNo: "0189012345",
      email: "emily.wong@example.com",
      postcode: "55667",
      state: "Sarawak",
      address: "78 Jalan Orchid, Kuching",
      occupation: "Lawyer",
      medicalHistory: [
        MedicalHistoryModel(condition: "Diabetes", medicine: "Metformin"),
        MedicalHistoryModel(condition: "Hypertension", medicine: "Lisinopril")
      ],
    ),
    PatientsModel(
      id: 9,
      name: "Ahmad Faizal",
      myKad: "890909-09-1234",
      gender: "Male",
      ethnicity: "Malay",
      mobileNo: "0190123456",
      email: "ahmad.faizal@example.com",
      postcode: "33445",
      state: "Kelantan",
      address: "90 Jalan Lavender, Kota Bharu",
      occupation: "Mechanic",
      medicalHistory: [
        MedicalHistoryModel(condition: "Diabetes", medicine: "Metformin"),
        MedicalHistoryModel(condition: "Hypertension", medicine: "Lisinopril")
      ],
    ),
    PatientsModel(
      id: 10,
      name: "Sophia Lee",
      myKad: "860101-13-6789",
      gender: "Female",
      ethnicity: "Chinese",
      mobileNo: "0112345678",
      email: "sophia.lee@example.com",
      postcode: "77889",
      state: "Pahang",
      address: "101 Jalan Tulip, Kuantan",
      occupation: "Architect",
      medicalHistory: [
        MedicalHistoryModel(condition: "Diabetes", medicine: "Metformin"),
        MedicalHistoryModel(condition: "Hypertension", medicine: "Lisinopril")
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    state.listen((v) {
      switch (v) {
        case LoaderState.initial:
        case LoaderState.loading:
          LoadingDialog.show();
          break;
        case LoaderState.empty:
        case LoaderState.loaded:
        case LoaderState.failure:
          LoadingDialog.hide();
          break;
      }
    });
    //loadPatients();
  }

  loadPatients() async {
    try {
      state.value = LoaderState.loading;
       final data = await repository.loadPatients();
        if (data.isEmpty || data == []) {
          return state.value = LoaderState.empty;
        }
        patients.value = data;
        //print(patients.value.last.medicalHistory.first.condition);
      //patients.value = dummyPatients;
      state.value = LoaderState.loaded;
    } catch (e) {
      print('Error loading patients: ${e.toString()}');
      state.value = LoaderState.failure;
    }
  }

  // Method to fetch patient details from the database
  Future<void> loadPatientDetails(String patientId) async {
    try {
      state.value = LoaderState.loading;
      // state.value = LoaderState.initial;
      // // Replace with your actual API call to fetch patient details
      final data = await repository.loadPatientById(patientId); //Assume this function exists
      // final data = await repository.loadPatientById(patientId);
      if (data == []) {
        state.value = LoaderState.empty;
      }
    
      // Access the value of Rx list first, then use firstWhere
      // final data = patients.value.firstWhere(
      //   (data) => data.id == int.parse(patientId),
      //   orElse: () => throw Exception('Patient not found'),
      // );
      //patients.value = dummyPatients.sublist(0,0);
      updatePatientInfo(
        id: int.parse(patientId),
        name: data.name,
        myKad: data.myKad,
        gender: data.gender,
        ethnicity: data.ethnicity,
        mobileNo: data.mobileNo,
        email: data.email,
        postcode: data.postcode,
        state: data.state,
        address: data.address,
        occupation: data.occupation,
        medicalHistory: data.medicalHistory
      );
      state.value = LoaderState.loaded;
    } catch (e) {
      //print(e.toString());
      state.value = LoaderState.failure;
    }
  }

  //  // Method to fetch patient details from the database
  // void loadPatientDetails(String patientId) async {
  //   try {
  //     state.value = LoaderState.initial;
  //     // Replace with your actual API call to fetch patient details
  //     //final data = await repository.loadPatientById(patientId); //Assume this function exists
  //     final data = await repository.loadPatientById(patientId);
  //     if (data == []) {
  //       //return state.value = LoaderState.empty;
  //     }
  //     //patients.value = dummyPatients.sublist(0,0);
  //     updatePatientInfo(
  //       name: data.name,
  //       myKad: data.myKad,
  //       gender: data.gender,
  //       ethnicity: data.ethnicity,
  //       mobileNo: data.mobileNo,
  //       email: data.email,
  //       postcode: data.postcode,
  //       state: data.state,
  //       address: data.address,
  //       occupation: data.occupation
  //     );
  //     state.value = LoaderState.loaded;
  //   } catch (e) {
  //     print(e.toString());
  //     state.value = LoaderState.failure;
  //   }
  // }

  void updatePatientInfo({
    int? id,
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
    List<MedicalHistoryModel>? medicalHistory,

  }) {
    currentPatient.update((patient) {
      if (patient != null) {
        if (id != null) patient.id = id;
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
        if (medicalHistory != null) patient.medicalHistory = medicalHistory;
      }
    });
  }

  void submitPatient() async {
    try {
      state.value = LoaderState.loading;

      // NEW CODE (Fixed)
      // Updated regex to allow 011 (digit 1)
      // if (!RegExp(r'^01[0-9]-[0-9]{7,8}$').hasMatch(phone)) {
      //   Get.snackbar("Error", "Invalid phone number format");
      //   return;
      // }


      await repository.submitPatient(currentPatient.value);
      toast("Patient added");

      state.value = LoaderState.loaded;

      // Reset the currentPatient after successful submission
      currentPatient.value = PatientsModel(
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
      );
    } catch (e) {
      toast("Failed to add patient");
      //print("This is the ADD PATIENT ERROR: " + e.toString());
      //print("Condition: ${currentPatient.value.medicalHistory.first.condition}");
      //print("Medicine: ${currentPatient.value.medicalHistory.first.medicine}");
      state.value = LoaderState.failure;
    }
  }

  void updatePatient(String? patientId) async {
    try {
      state.value = LoaderState.loading;
      currentPatient.value.id = int.parse(patientId!);
      await repository.updatePatient(currentPatient.value);
      toast("Patient updated");

      state.value = LoaderState.loaded;

      // Reset the currentPatient after successful submission
      currentPatient.value = PatientsModel(
        id: null,
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
      );
    } catch (e) {
      toast("Failed to update patient");
      //print("This is the UPDATE PATIENT ERROR: " + e.toString());
      state.value = LoaderState.failure;
    }
  }

  void deletePatient(String patientId) async {
    try {
      state.value = LoaderState.loading;
      await repository.deletePatientById(patientId);

      toast("Sucessful delete Patient${currentPatient.value.name}");
      state.value = LoaderState.loaded;
    } catch (e) {
      toast("Failed to delete patient");
      //print("This is the DELETE ERROR: " + e.toString());
      state.value = LoaderState.failure;
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

  void clearMedicalHistory() {
    currentPatient.value.medicalHistory = [];
  }

  void clearCurrentPatient() {
    currentPatient.value.id = null;
    currentPatient.value.name = '';
    currentPatient.value.myKad = '';
    currentPatient.value.gender = '';
    currentPatient.value.ethnicity = '';
    currentPatient.value.mobileNo = '';
    currentPatient.value.email = '';
    currentPatient.value.postcode = '';
    currentPatient.value.state = '';
    currentPatient.value.address = '';
    currentPatient.value.occupation = '';
    currentPatient.value.medicalHistory = [];
  }

  //This is a simulation for SMCM project (check label status)
  //void addFeature() {
  //  addCategoryLabel();
  //}

  //This is a simulation for smcm project (get medical notes preview)
  //void getMedicalNotesPreview() {
  //  currentPatient.value.medicalNote = repository.load(medicalNote);
  //  
  //
  //
  //}
  //NEW CODE (New Feature) void filterPatients(DateTime? visitDate, bool? active) {
//filteredPatients = allPatients.where((patient){
//final matchesDate = visitDate == null ||
//patient.lastVisitDate.isAfter(visitDate);
//final matchesStatus = activeStatus == null ||
//patient.name.isActive == activeStatus;
//
//return matchesDate && matchesStatus;
//}).toList();
//}
//}

}

