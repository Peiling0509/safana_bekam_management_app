import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/home/notification_controller.dart';

class NotificationBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
  }

}