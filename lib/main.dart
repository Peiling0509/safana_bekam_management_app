import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/routes.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onInit: onInit,
      onReady: onReady,
      onDispose: onDispose,
      title: 'Safana Bekam Management App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/login',
      getPages: routes,
    );
  }

   void onInit() {
    Get.put(AuthController());
  }

  void onReady() {}

  void onDispose() {
    Get.delete<AuthController>();
  }
}
