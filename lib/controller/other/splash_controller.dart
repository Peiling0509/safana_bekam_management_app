import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> positionAnimation;

  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration
    );

    // Tween for moving logo from bottom to top
    positionAnimation = Tween<double>(
      begin: Get.height * 0.4, // Start at the center
      end: Get.height * 0.25, // End slightly higher
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.8,
            curve: Curves.easeInOut), // 80% for position animation
      ),
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
