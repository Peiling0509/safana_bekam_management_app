import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/loading_dialog.dart';
import 'package:safana_bekam_management_app/components/toast.dart';
import 'package:safana_bekam_management_app/data/model/form/login_form._model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';

class LoginController extends GetxController{

  Rx<bool> isObscuredPass = true.obs;
  final Rx<LoaderState> state = LoaderState.initial.obs;

  late Rx<LoginFormModel> form;
  final formKey = GlobalKey<FormState>();

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
  }

  submit(){
    try {
      state.value = LoaderState.loading;
      Get.offAllNamed("/home");
      state.value = LoaderState.loaded;
      
    } catch (e) {
      toast("Failed login");
      debugPrint(e.toString());
    }

  }
}