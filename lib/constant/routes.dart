import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:safana_bekam_management_app/binding/home/notifications_binding.dart';
import 'package:safana_bekam_management_app/binding/home/root_home_binding.dart';
import 'package:safana_bekam_management_app/binding/login/login_binding.dart';
import 'package:safana_bekam_management_app/binding/other/splash_binding.dart';
import 'package:safana_bekam_management_app/binding/profile/profile_binding.dart';
import 'package:safana_bekam_management_app/binding/treatment/remark_binding.dart';
import 'package:safana_bekam_management_app/binding/treatment/treatment_binding.dart';
import 'package:safana_bekam_management_app/screen/home/notification_screen.dart';
import 'package:safana_bekam_management_app/screen/home/root_home_screen.dart';
import 'package:safana_bekam_management_app/screen/login/login_screen.dart';
import 'package:safana_bekam_management_app/screen/other/splash_screen.dart';
import 'package:safana_bekam_management_app/screen/profile/edit_profile_screen.dart';
import 'package:safana_bekam_management_app/screen/treatment/record_treatment_screen.dart';
import 'package:safana_bekam_management_app/screen/treatment/remark_screen.dart';

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
    binding: RootHomeBinding(),
  ),
  GetPage(
    name: '/notifications',
    page: () => const NotificationScreen(),
    binding: NotificationBinding(),
  ),
  GetPage(
    name: '/edit_profile',
    page: () => const EditProfileScreen(),
    binding: ProfileBinding(),
  ),
  GetPage(
    name: '/record_treatment',
    page: () => const RecordTreatmentScreen(),
    binding: TreatmentBinding(),
  ),
  GetPage(
    name: '/remark',
    page: () => const RemarkScreen(),
    binding: RemarkBinding(),
  ),
];
