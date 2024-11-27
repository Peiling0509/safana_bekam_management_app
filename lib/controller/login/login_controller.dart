import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/custom_loading_dialog.dart';
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
         // CustomLoadingDialog.show(context, message: 'Please wait...');
          break;
        case LoaderState.loaded:
        case LoaderState.failure:
          //CustomLoadingDialog.hide(context);
          break;
      }
    });

  }
}