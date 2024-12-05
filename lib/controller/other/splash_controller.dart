import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> positionAnimation;

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
        // Navigate only after animation is finished
        Get.offAllNamed('/login');
      }
    });
    // Future.delayed(
    //   const Duration(seconds: 1),
    //   () {
    //     Get.offAllNamed('/login');
    //     // if (auth.isLogin()) {
    //     //   Get.offAllNamed("/home");
    //     // } else {
    //     //   Get.offAllNamed('/login');
    //     // }
    //   },
    // );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
