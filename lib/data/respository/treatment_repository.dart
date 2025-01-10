import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safana_bekam_management_app/constant/api.dart';
import 'package:safana_bekam_management_app/data/model/treatment/treatment_model.dart';
import 'package:safana_bekam_management_app/data/provider/api_provider.dart';

class TreatmentRepository {
  final APIProvider provider = Get.find<APIProvider>();

  Future<TreatmentResponseModel> loadTreatment(
      String patientId, String recordId) async {
    Map<String, dynamic> formData = {
      "patient_id": patientId,
      "record_id": recordId,
    };

    final res = await provider.post(API.EXPORT_TREATMENT, formData: formData);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return TreatmentResponseModel.fromJson(res.data);
  }

  Future<dynamic> submitTreatment(TreatmentModel treatment) async {
    Map<String, dynamic> body = {
      "patient_id": treatment.patientId,
      "therapist_id": treatment.therapistId,
      "frequency": treatment.frequency ?? "1",
      "created_date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "blood_pressure_before": treatment.bloodPressureBefore,
      "blood_pressure_after": treatment.bloodPressureAfter,
      "package": treatment.package,
      "health_complications": treatment.healthComplications,
      "comments": treatment.comments,
      "acupuncture_point": treatment.remarks!
          .expand((acupoints) => acupoints.acupoint!.map((acupoint) => [
                acupoints.bodyPart,
                acupoint.point!.dx,
                acupoint.point!.dy,
                acupoint.skinReaction,
                acupoint.bloodQuantity,
              ]))
          .toList(),
    };

    print(jsonEncode(body));

    final res = await provider.jsonPost(API.SUBMIT_TREATMENT, body: body);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return res;
  }

  // Future<void> updateTreatment(Treatment treatment) async {
  //   return _treatmentDataSource.updateTreatment(treatment);
  // }

  // Future<void> deleteTreatment(String id) async {
  //   return _treatmentDataSource.deleteTreatment(id);
  // }
}
