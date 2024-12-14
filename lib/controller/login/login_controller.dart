import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/components/toast.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';
import 'package:safana_bekam_management_app/data/model/form/login_form._model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';
import 'package:safana_bekam_management_app/data/respository/login_respository.dart';

class LoginController extends GetxController {
  Rx<bool> isObscuredPass = true.obs;
  final Rx<LoaderState> state = LoaderState.initial.obs;

  late Rx<LoginFormModel> form;
  final formKey = GlobalKey<FormState>();
  final repository = LoginRepository();
  final authController = Get.find<AuthController>();

  var usernameError = ''.obs;
  var passwordError = ''.obs;

  final box = GetStorage("Login");
  String? userName() => box.read("username");
  String? password() => box.read("password");
  bool? isRememberMe() => box.read("is_remember_me") ?? true;

  @override
  void onInit() {
    super.onInit();
    form = LoginFormModel().obs;
    state.listen((v) {
      switch (v) {
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

    setUsername = userName() ?? "";
    setPassword = password() ?? "";
  }

  submit() async {
    try {
      if (!validateForm()) return;
      state.value = LoaderState.loading;
      final data = await repository.login(form.value);
      authController.login(data);
      rememberMe();
      toast("Login success");
      Get.offAllNamed("/home");
      state.value = LoaderState.loaded;
    } catch (e) {
      state.value = LoaderState.failure;
      toast("Login failed");
      debugPrint(e.toString());
    }
  }

  bool validateForm() {
    usernameError.value = getUsername.isEmpty ? "Username can't be empty" : '';
    passwordError.value = getPassword.isEmpty ? "Password can't be empty" : '';

    return usernameError.value.isEmpty && passwordError.value.isEmpty;
  }

  Future<void> rememberMe() async {
    if (isRememberMe() == true) {
      await box.write("username", getUsername);
      await box.write("password", getPassword);
    } else {
      await box.write("username", "");
      await box.write("password", "");
    }
    await box.save();
  }

  Future<void> setRememberMe(bool? answer) async {
    await box.write("is_remember_me", answer ?? false);
    await box.save();
  }

  set setUsername(String value) => form.value.username = value;
  set setPassword(String value) => form.value.password = value;

  get getUsername => form.value.username;
  get getPassword => form.value.password;
}
