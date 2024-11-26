import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:safana_bekam_management_app/binding/home/root_home_binding.dart';
import 'package:safana_bekam_management_app/binding/login/login_binding.dart';
import 'package:safana_bekam_management_app/binding/other/splash_binding.dart';
import 'package:safana_bekam_management_app/screen/home/root_home_screen.dart';
import 'package:safana_bekam_management_app/screen/login/login_screen.dart';
import 'package:safana_bekam_management_app/screen/other/splash_screen.dart';

List<GetPage> routes = [
  GetPage(
    name: '/',
    page: () => SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: '/login',
    page: () => const LoginScreen(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: '/home',
    page: () => RootHomeScreen(),
    bindings: [RootHomeBinding()],
  ),
];
