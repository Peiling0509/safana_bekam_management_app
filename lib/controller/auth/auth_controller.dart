import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/components/toast.dart';
import 'package:safana_bekam_management_app/data/model/auth/auth_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';
import 'package:safana_bekam_management_app/data/model/user/user_roles_model.dart';
import 'package:safana_bekam_management_app/data/respository/user_repository.dart';

class AuthController extends GetxController {
  final Rx<LoaderState> state = LoaderState.initial.obs;
  final userForm = UserModel().obs;
  final box = GetStorage("Auth");

  List<dynamic>? userRoles() {
    var roles = box.read("role");
    print("Retrieved roles: $roles");
    return roles;
  }

  String? lastLoginDateTime() => box.read("last_login_date_time");

  final repository = UserRepository();

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
    checkAuthenticationStatus();
  }

  setUserForm() {
    try {
      state.value = LoaderState.loading;
      String? userInfoString = box.read("user_info");
      if (userInfoString != null) {
        Map<String, dynamic> userInfoJson = jsonDecode(userInfoString);
        userForm.value = UserModel.fromJson(userInfoJson);
      }
      state.value = LoaderState.loaded;
    } catch (e) {
      state.value = LoaderState.failure;
      print(e.toString());
    }
  }

  Future<void> login(AuthModel data) async {
    await box.write("user_info", jsonEncode(data.user!.toJson()));
    await box.write("role", data.user?.role);
    await box.write("last_login_date_time",
        DateFormat("dd-MM-yyyy h:mm a").format(DateTime.now()));
    await box.save();
    setUserForm();
  }

  Future<void> logout() async {
    state.value = LoaderState.loading;
    await box.erase();
    await box.save();
    Get.offAllNamed("/login");
    state.value = LoaderState.loaded;
  }

  Future<void> updateProfile() async {
    try {
      state.value = LoaderState.loading;
      final res = await repository.updateUser(userForm.value);
      toast(res.data["message"]);
      // Update user info in GetStorage
      await box.write("user_info",
          jsonEncode(userForm.value.toJson())); // Save updated user info
      await box.save();
      state.value = LoaderState.loaded;
    } catch (e) {
      state.value = LoaderState.failure;
      toast("Failed update profile");
      print(e.toString());
    }
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

  bool canPerformAction({required String action}) {
    // Check each role's permissions to see if the action is allowed
    final roles = userRoles() ??
        [userRolesModel.admin]; // Default to admin if no roles found
    for (var role in roles.map((r) => r.toString()).toList()) {
      // Ensure we treat as strings
      //print("Checking role: $role"); // Debug print for the current role
      // Ensure the role exists in the permissions map
      if (userRolesModel.rolePermissions.containsKey(role)) {
        if (userRolesModel.rolePermissions[role]?.contains(action) == true) {
          //print("$action : able"); // Debug print for action permission
          return true; // User has permission for the action
        } else {
          //print("$action : unable in role $role"); // Debug print for action denial
        }
      } else {
        //print("Role $role not found in permissions map."); // Additional debug output
      }
    }
    return false; // No permission found for the action
  }

  // Getters
  get getId => userForm.value.id;
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
