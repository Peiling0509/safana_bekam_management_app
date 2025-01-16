import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';
import 'package:safana_bekam_management_app/data/respository/dashboard_repository.dart';

class DashboardController extends GetxController {
  final Rx<LoaderState> state = LoaderState.initial.obs;

  final repository = DashboardRepository();

  Rx<String> totalPatientsCount = "null".obs;
  Rx<String> newPatientDailyCount = "null".obs;
  Rx<String> newPatientMonthlyCount = "null".obs;
  Rx<String> newTreatmentDailyCount = "null".obs;

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
  }

  load() async {
    try {
      state.value = LoaderState.loading;
      totalPatientsCount.value = await repository.loadTotalPatients();
      newPatientDailyCount.value = await repository.loadPatientsDaily();
      newPatientMonthlyCount.value = await repository.loadPatientsMonthly();
      newTreatmentDailyCount.value = await repository.loadTreatmentsDaily();
      state.value = LoaderState.loaded;
    } catch (e) {
      print('Error loading dashboard: ${e.toString()}');
      state.value = LoaderState.failure;
    }
  }
}
