import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashController extends GetxController with GetSingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration
    );

    // Tween for moving logo from bottom to top
    animation = Tween<double>(
      begin: Get.height * 0.5, // Start below the center
      end: -50.0, // End slightly above the center
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
    );

    // Start the animation
    animationController.forward();
  }

  //final auth = Get.find<AuthController>();
  @override
  void onReady() {
    super.onReady();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed('/login');
        // if (auth.isLogin()) {
        //   Get.offAllNamed("/home");
        // } else {
        //   Get.offAllNamed('/login');
        // }
      },
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}