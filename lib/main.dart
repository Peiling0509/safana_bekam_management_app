import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/constant/routes.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';
import 'package:safana_bekam_management_app/data/provider/api_provider.dart';

void main() async {
  await GetStorage.init(); 
  await GetStorage.init("Login");
  await GetStorage.init("Auth");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onInit: onInit,
      onDispose: onDispose,
      title: 'Safana Bekam Management App',
      color: ConstantColor.primaryColor,
      theme: ThemeData(
        primaryColor: ConstantColor.primaryColor,
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          backgroundColor: ConstantColor.primaryColor,
          centerTitle: true,
            elevation: 0.0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: ConstantColor.primaryColor,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 30),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ConstantColor.primaryColor,
          ),
        ),
      ),
      initialRoute: '/home',
      getPages: routes,
    );
  }

  void onInit() {
    Get.put(APIProvider());
    Get.put(AuthController());
  }

  void onDispose() {
    Get.delete<APIProvider>();
    Get.delete<AuthController>();
  }
}
