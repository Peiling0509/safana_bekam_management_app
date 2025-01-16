import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';
import 'package:safana_bekam_management_app/controller/other/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: AnimatedBuilder(
        animation: controller.animationController,
        builder: (context, child) {
          return Center(
            child: Image.asset(
              AssetPath.logo,
              height: Get.height * 0.2,
              width: Get.width * 0.6,
            ),
          );
        },
      ),
    );
  }
}
