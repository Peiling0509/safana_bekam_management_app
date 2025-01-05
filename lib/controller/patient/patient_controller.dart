import 'package:get/get.dart';

import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/data/model/patients/patients_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';
import 'package:safana_bekam_management_app/data/respository/patient_respository.dart';

class PatientController extends GetxController {
  final Rx<LoaderState> state = LoaderState.initial.obs;

  final repository = PatientsRepository();
  Rx<List<PatientsModel>> patients = Rx<List<PatientsModel>>([]);

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
      medicalHistory: ["Hypertension"],
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
      medicalHistory: ["Asthma"],
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
      medicalHistory: ["Diabetes"],
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
      medicalHistory: ["None"],
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
      medicalHistory: ["Allergy to nuts"],
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
      medicalHistory: ["Migraine"],
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
      medicalHistory: ["Anemia"],
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
      medicalHistory: ["None"],
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
      medicalHistory: ["High cholesterol"],
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
      medicalHistory: ["None"],
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
      // final data = await repository.loadPatients();
      // if (data.isEmpty || data == []) {
      //   return state.value = LoaderState.empty;
      // }
      //patients.value = data;
      patients.value = dummyPatients;
      state.value = LoaderState.loaded;
    } catch (e) {
      print(e.toString());
      state.value = LoaderState.failure;
    }
  }

}