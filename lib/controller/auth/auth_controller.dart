import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/data/model/auth/auth_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';

class AuthController extends GetxController {
  final Rx<LoaderState> state = LoaderState.initial.obs;
  final userForm = UserModel().obs;
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

  setUserForm() {
    String? userInfoString = box.read("user_info");
    if (userInfoString != null) {
      Map<String, dynamic> userInfoJson = jsonDecode(userInfoString);
      userForm.value = UserModel.fromJson(userInfoJson);
    }
  }

  Future<void> login(AuthModel data) async {
    await box.write("user_info", jsonEncode(data.user!.toJson()));
    await box.write("role", data.user?.role);
    await box.write("last_login_date_time",
        DateFormat("dd-MM-yyyy h:mm a").format(DateTime.now()));
    await box.save();
  }

  Future<void> logout() async {
    state.value = LoaderState.loading;
    await box.erase();
    await box.save();
    Get.offAllNamed("/login");
    state.value = LoaderState.loaded;
  }

  // Method to check authentication status
  Future<void> checkAuthenticationStatus() async {
    try {
      // Check if authentication box has stored data
      final storedCookies = box.read("cookies");
      if (storedCookies != null && storedCookies.isNotEmpty) {
        Get.offAllNamed('/home');
      } else {
        // Navigate to login if session is invalid
        Get.offAllNamed('/login');
      }
    } catch (e) {
      // Handle any errors during authentication check
      print('Authentication Check Error: $e');
      Get.offAllNamed('/login');
    }
  }

  // Getters
  get getId => userForm.value.id ?? 0;
  get getProfilePicture => userForm.value.profilePicture ?? "null";
  get getUsername => userForm.value.username ?? "null";
  get getEmail => userForm.value.email ?? "null";
  get getMobileNo => userForm.value.mobileNo ?? "null";
  get getAddress => userForm.value.address ?? "null";
  get getRoleUser => userForm.value.role;

  // Setters
  set setProfilePicture(String? value) => userForm.value.profilePicture = value;
  set setUsername(String? value) => userForm.value.username = value;
  set setEmail(String? value) => userForm.value.email = value;
  set setMobileNo(String? value) => userForm.value.mobileNo = value;
  set setAddress(String? value) => userForm.value.address = value;
}
