// Model class for Notification
class NotificationModel {
  final int notificationId;
  final String dateCreated;
  final String message;
  final String notificationType;

  NotificationModel({
    required this.notificationId,
    required this.dateCreated,
    required this.message,
    required this.notificationType,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notification_id'],
      dateCreated: json['date_created'],
      message: json['message'],
      notificationType: json['notification_type'],
    );
  }
}