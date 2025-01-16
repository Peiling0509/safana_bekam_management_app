import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safana_bekam_management_app/constant/api.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';
import 'package:safana_bekam_management_app/data/model/treatment/patient_treatments_model.dart';
import 'package:safana_bekam_management_app/data/model/treatment/treatment_model.dart';
import 'package:safana_bekam_management_app/data/provider/api_provider.dart';

class TreatmentRepository {
  final APIProvider provider = Get.find<APIProvider>();
  final authController =  Get.find<AuthController>();

  Future<PatientTreatmentsModel> loadTreatments(String patientId) async {
    Map<String, dynamic> formData = {
      "patient_id": patientId,
    };

    final res = await provider.post(API.EXPORT_TREATMENTS, formData: formData);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return PatientTreatmentsModel.fromJson(res.data);
  }

  Future<TreatmentResponseModel> loadTreatmentDetails(
      String patientId, String recordId) async {
    Map<String, dynamic> formData = {
      "patient_id": patientId,
      "record_id": recordId,
    };

    final res =
        await provider.post(API.EXPORT_TREATMENT_DETAILS, formData: formData);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return TreatmentResponseModel.fromJson(res.data);
  }

  Future<dynamic> submitTreatment(TreatmentModel treatment) async {
    Map<String, dynamic> body = {
      "patient_id": treatment.patientId,
      "therapist_id": authController.getId,
      "frequency": treatment.frequency,
      "created_date": treatment.createdData,
      "blood_pressure_before": treatment.bloodPressureBefore,
      "blood_pressure_after": treatment.bloodPressureAfter,
      "package": treatment.package,
      "health_complications": treatment.healthComplications,
      "comments": treatment.comments,
      "acupuncture_point": treatment.remarks!
          .expand((acupoints) => acupoints.acupoint!.map((acupoint) => {
                "body_part": acupoints.bodyPart,
                "coordinate_x": acupoint.point!.dx,
                "coordinate_y": acupoint.point!.dy,
                "skin_reaction": acupoint.skinReaction,
                "blood_quantity": acupoint.bloodQuantity,
              }))
          .toList(),
    };

    print(jsonEncode(body));

    final res = await provider.jsonPost(API.SUBMIT_TREATMENT, body: body);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return res;
  }

  Future<dynamic> updateTreatment(TreatmentModel treatment, String currentTreatmentId) async {
    Map<String, dynamic> body = {
      "record_id": currentTreatmentId,
      "frequency": treatment.frequency,
      "created_date": treatment.createdData,
      "blood_pressure_before": treatment.bloodPressureBefore,
      "blood_pressure_after": treatment.bloodPressureAfter,
      "package": treatment.package,
      "health_complications": treatment.healthComplications,
      "comments": treatment.comments,
      "acupuncture_point": treatment.remarks!
          .expand((acupoints) => acupoints.acupoint!.map((acupoint) => {
                "body_part": acupoints.bodyPart,
                "coordinate_x": acupoint.point!.dx,
                "coordinate_y": acupoint.point!.dy,
                "skin_reaction": acupoint.skinReaction,
                "blood_quantity": acupoint.bloodQuantity,
              }))
          .toList(),
    };

    print(jsonEncode(body));

    final res = await provider.jsonPost(API.UPDATE_TREATMENT, body: body);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return res;
  }

  Future<dynamic> deleteTreatment(String currentTreatmentId) async {

    Map<String, dynamic> formData = {
      "record_id": currentTreatmentId,
    };

    final res = await provider.post(API.DELETE_TREATMENT, formData: formData);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return res;
  }
}
