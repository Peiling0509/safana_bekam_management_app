import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration
    );

    // Start the animation after a delay of 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      animationController.forward();
    });
  }

  //final auth = Get.find<AuthController>();
  @override
  void onReady() {
    super.onReady();

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        authController.checkAuthenticationStatus();
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
