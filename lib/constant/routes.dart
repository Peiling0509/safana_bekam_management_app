import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:safana_bekam_management_app/binding/login/login_binding.dart';
import 'package:safana_bekam_management_app/screen/login_screen.dart';

List<GetPage> routes = [
  // GetPage(
  //   name: '/',
  //   page: () => const SplashScreen(),
  //   binding: SplashBinding(),
  // ),
  GetPage(
    name: '/login',
    page: () => const LoginScreen(),
    binding: LoginBinding(),
  ),
  // GetPage(
  //   name: '/home',
  //   page: () => const HomeScreen(),
  //   binding: HomeBinding(),
  // ),
];