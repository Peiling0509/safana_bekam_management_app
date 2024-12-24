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
}
