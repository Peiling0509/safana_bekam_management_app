import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/data/model/auth/auth_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';

class AuthController extends GetxController {
  final Rx<LoaderState> state = LoaderState.initial.obs;
  final box = GetStorage("Auth");

  String? role() => box.read("role");
  String? lastLoginDateTime() => box.read("last_login_date_time");

  @override
  void onInit() {
    super.onInit();
    state.listen((v) {
      switch (v) {
        case LoaderState.empty:
        case LoaderState.initial:
        case LoaderState.loading:
          LoadingDialog.show();
          break;
        case LoaderState.loaded:
        case LoaderState.failure:
          LoadingDialog.hide();
          break;
      }
    });
  }

  UserModel? getUserInfo() {
    String? userInfoString = box.read("user_info");
    if (userInfoString != null) {
      Map<String, dynamic> userInfoJson = jsonDecode(userInfoString);
      return UserModel.fromJson(userInfoJson);
    }
    return null;
  }

  Future<void> login(AuthModel data) async {
    await box.write("user_info", jsonEncode(data.user!.toJson()));
    await box.write("role", data.user?.role);
    await box.write("last_login_date_time", DateFormat('dd-MM-yyyy h:m:s a').format(DateTime.now()));
    await box.save();
  }

  Future<void> logout() async {
    state.value = LoaderState.loading;
    await box.erase();
    await box.save();
    Get.offAllNamed("/login");
    state.value = LoaderState.loaded;
  }
}
