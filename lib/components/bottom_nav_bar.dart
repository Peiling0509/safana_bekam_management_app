import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/home/root_home_controller.dart';

class CustomBottomNavigationBar extends GetView<RootHomeController> {
  const CustomBottomNavigationBar({super.key});

  List<BottomNavigationBarItem> _buildNavItem() => [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "Home",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_search_outlined),
          activeIcon: Icon(Icons.person_search),
          label: "Search",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: "Profile",
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (Get.size.shortestSide >= 600 ? 80 : 60) + 20,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 20),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), // Top-left rounded
          topRight: Radius.circular(30), // Top-right rounded
        ),
        child: Obx(() => BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: (index) => controller.goTo(index),
              items: _buildNavItem(),
            )),
      ),
    );
  }
}
