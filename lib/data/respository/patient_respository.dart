import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/api.dart';
import 'package:safana_bekam_management_app/data/model/patients/patient_records_model.dart';
import 'package:safana_bekam_management_app/data/model/patients/patients_model.dart';
import 'package:safana_bekam_management_app/data/provider/api_provider.dart';

class PatientsRepository {
  final APIProvider provider = Get.find<APIProvider>();

  Future<List<PatientsModel>> loadPatients() async {
    final res = await provider.get(API.EXPORT_PATIENTS);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return (res.data as List<dynamic>)
        .map((e) => PatientsModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PatientRecordModel> loadPatientRecords(String patientId) async {
    Map<String, dynamic> formData = {
      "patient_id": patientId,
    };

    final res =
        await provider.post(API.EXPORT_PATIENT_RECORDS, formData: formData);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return PatientRecordModel.fromJson(res.data);  
  }

  
  Future<PatientsModel> loadPatientbyId(String patientId) async {
    final res = await provider.get('${API.EXPORT_PATIENTS}/$patientId');

    if (res.statusCode != 200) throw res;

    return PatientsModel.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> submitPatient(PatientsModel patient) async {
    List<String> serializedMedicalHistory = patient.medicalHistory
        .map((history) => "\${history.condition}, \${history.medicine}")
        .toList();

    Map<String, dynamic> formData = {
      'name': patient.name,
      'mykad': patient.myKad,
      'gender': patient.gender,
      'ethnicity': patient.ethnicity,
      'p_mobile_no': patient.mobileNo,
      'p_email': patient.email,
      'postcode': patient.postcode,
      'state': patient.state,
      'address': patient.address,
      'occupation': patient.occupation,
      'medical_history': ["Testing"],
    };
    
    final res = await provider.post(
      API.REGISTER_PATIENT,
      formData: formData,
    );

    if (res.statusCode != 200) throw res;
  }

  // Update existing patient
  Future<void> updatePatient(PatientsModel patient) async {
    try {
      if (patient.id == null) {
        throw Exception('Patient ID is required for update');
      }

      Map<String, dynamic> formData = _createPatientFormData(patient);
      formData['id'] = patient.id; // Include ID for update

      final res = await http.put(
        Uri.parse('${API.REGISTER_PATIENT}/${patient.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(formData),
      );

      if (res.statusCode != 200) throw res;
    } catch (e) {
      print('Error updating patient: $e');
      throw e;
    }
  }

  // Helper method to create form data
  Map<String, dynamic> _createPatientFormData(PatientsModel patient) {
    // Convert medical history to the format expected by the API
    List<Map<String, dynamic>> serializedMedicalHistory = patient.medicalHistory
        .map((history) => history.toJson())
        .toList();

    return {
      'name': patient.name,
      'mykad': patient.myKad,
      'gender': patient.gender,
      'ethnicity': patient.ethnicity,
      'p_mobile_no': patient.mobileNo,
      'p_email': patient.email,
      'postcode': patient.postcode,
      'state': patient.state,
      'address': patient.address,
      'occupation': patient.occupation,
      'medical_history': serializedMedicalHistory,
      // If you need to keep the test data, uncomment below
      // 'medical_history': ["This is a bug testing list", "Second test"],
    };
  }
}
