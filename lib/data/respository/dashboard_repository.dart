import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/api.dart';
import 'package:safana_bekam_management_app/data/model/dashboard/patients_montht_sorted_model.dart';
import 'package:safana_bekam_management_app/data/provider/api_provider.dart';

class DashboardRepository{
  final APIProvider provider = Get.find<APIProvider>();

  Future<String> loadPatientsDaily() async {
    final res = await provider.get(API.EXPORT_PATIENTS_DAILY);

    if (res.statusCode != 200) throw res;
    if (res.data["status"] != "success") throw res;

    return res.data["count"].toString();
  }

  Future<String> loadPatientsMonthly() async {
    final res = await provider.get(API.EXPORT_PATIENTS_MONTHLY);

    if (res.statusCode != 200) throw res;
    if (res.data["status"] != "success") throw res;

    return res.data["count"].toString();
  }

  Future<String> loadTotalPatients() async {
    final res = await provider.get(API.EXPORT_TOTAL_PATIENTS);

    if (res.statusCode != 200) throw res;
    if (res.data["status"] != "success") throw res;

    return res.data["count"].toString();
  }

  Future<String> loadTreatmentsDaily() async {
    final res = await provider.get(API.EXPORT_TREATMENT_DAILY);

    if (res.statusCode != 200) throw res;
    if (res.data["status"] != "success") throw res;

    return res.data["count"].toString();
  }

   Future<PatientMonthlySortedModel> loadPatientsMonthlySorted() async {
   
    final res = await provider.get("${API.EXPORT_PATIENTS_MONTHLY_SORTED}${DateTime.now().year}");//get current year

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    return PatientMonthlySortedModel.fromJson(res.data);
  }
}