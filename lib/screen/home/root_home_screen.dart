import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/bottom_nav_bar.dart';
import 'package:safana_bekam_management_app/controller/home/root_home_controller.dart';

class RootHomeScreen extends StatelessWidget {
  RootHomeScreen({super.key});

  final controller = Get.find<RootHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Obx(() => controller.screens[controller.currentIndex.value]),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}


