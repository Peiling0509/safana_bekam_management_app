import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/screen/Home/home_screen.dart';
import 'package:safana_bekam_management_app/screen/home/dashboard_screen.dart';
import 'package:safana_bekam_management_app/screen/profile/profile_screen.dart';
import 'package:safana_bekam_management_app/screen/home/search_patient_screen.dart';

class RootHomeController extends GetxController {
  var currentIndex = 0.obs;

  late List<Widget> screens;

  @override
  void onInit() {
    super.onInit();
     screens = [
      const DashboardScreen(),
      const HomeScreen(),
      const SearchPatientScreen(),
      const ProfileScreen(),
    ];
  }

  goTo(int index){
    if(screens.asMap().containsKey(index)){
      currentIndex.value = index;
    }
  }
}
