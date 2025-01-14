import 'dart:convert';
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

    final res = await provider.post(API.EXPORT_PATIENT_RECORDS, formData: formData);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return PatientRecordModel.fromJson(res.data);  
  }

  Future<PatientsModel> loadPatientById(String patientId) async {
    Map<String, dynamic> formData = {
      "patient_id": patientId,
    };

    final res = await provider.post(API.EXPORT_PATIENTS, formData: formData);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return PatientsModel.fromJson(res.data);
  }

  Future<void> submitPatient(PatientsModel patient) async {
    Map<String, dynamic> formData = _createPatientFormData(patient);

    final res = await provider.jsonPost(
      API.REGISTER_PATIENT,
      body: formData,
    );

    // Check for non-200 status codes and only throw if necessary
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Failed to submit patient: ${res}');
    }

    // Optional: Log response for debugging
    print("Response received: ${res}");
}

  Future<void> updatePatient(PatientsModel patient) async {
    
    if (patient.id == null) {
      throw Exception('Patient ID is required for update');
    }

    Map<String, dynamic> formData = _createPatientFormData(patient);
    formData['patient_id'] = patient.id;

    final res = await provider.jsonPost(
      API.UPDATE_PATIENT,
      body: formData
    );

    // Check for non-200 status codes and only throw if necessary
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Failed to update patient: ${res}');
    }

    // Optional: Log response for debugging
    print("Response received: ${res}");

  }

  Future<void> deletePatientById(String patientId) async {
    try {
      final Map<String, dynamic> formData = {
        'patient_id': patientId,
      };

      final res = await provider.post(
        //'${API.DELETE_PATIENT}/$patientId',
          API.DELETE_PATIENT,
        formData: formData,
      );

      if (res.statusCode != 200 && res.statusCode != 204) {
        throw Exception('Failed to delete patient: ${res.statusMessage}');
      }

      print('Successfully deleted patient with ID: $patientId');
    } catch (e) {
      print('Error deleting patient: $e');
      throw e;
    }
  } 

  Map<String, dynamic> _createPatientFormData(PatientsModel patient) {
    // List<String?> serializedMedicalHistory = patient.medicalHistory
    //     .map((history) => history.condition)
    //     .toList();

    // List<String?> serializedTreatmentHistory = patient.medicalHistory
    //     .map((history) => history.medicine)
    //     .toList();

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
      'medical_history': patient.medicalHistory,
      //'medical_history': serializedMedicalHistory,
      //'treatment_history': serializedTreatmentHistory,
    };
  }
}