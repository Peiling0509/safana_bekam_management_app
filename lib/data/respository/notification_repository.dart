import 'package:safana_bekam_management_app/constant/api.dart';
import 'package:safana_bekam_management_app/data/model/notification/notifications_model.dart';
import 'package:safana_bekam_management_app/data/provider/api_provider.dart';
import 'package:get/get.dart';

class NotificationRepository {
  final APIProvider provider = Get.find<APIProvider>();

  Future<List<NotificationModel>> loadNotification() async {
    final res = await provider.get(API.EXPORT_NOTIFICATIONS);

    if (res.statusCode != 200 && res.statusCode != 201) throw res;

    // Access the notifications array from the response
    final List<dynamic> notificationsList = res.data['notifications'];
    
    return notificationsList
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}