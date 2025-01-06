import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/api.dart';
import 'package:safana_bekam_management_app/data/model/patients/patients_model.dart';
import 'package:safana_bekam_management_app/data/provider/api_provider.dart';

class PatientsRepository {
  final APIProvider provider = Get.find<APIProvider>();

  Future<List<PatientsModel>> loadPatients() async {
    final res = await provider.get(API.EXPORT_PATIENTS);

    if (res.statusCode != 200) throw res;

    return (res.data as List<dynamic>)
        .map((e) => PatientsModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> submitPatient(PatientsModel patient) async {

    List<Map<String, dynamic>> serializedMedicalHistory = patient.medicalHistory
        .map((history) => history.toJson())
        .toList();

    Map<String, dynamic> formData = {
      //'id': patient.id,
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
      'medical_history': ["This is a bug testing list", "Second test"],
      }
    ;
    /*
    final res = await provider.post(
      API.REGISTER_PATIENT,
      formData: formData,
    );*/

    final res = await http.post(
      Uri.parse(API.REGISTER_PATIENT),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(formData),
    );

    if (res.statusCode != 200) throw res;
  }
}
