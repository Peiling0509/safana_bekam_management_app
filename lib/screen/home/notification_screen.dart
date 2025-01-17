import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/controller/notification/notification_controller.dart';

import 'package:safana_bekam_management_app/data/model/notification/notifications_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationController());
    // Load notifications when screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.state.value == LoaderState.initial) {
        controller.loadNotification();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ConstantColor.primaryColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 28,
                      )),
                    const Text(
                      "Notis",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 28),
                    )
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.loadNotification();
                  },
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Obx(() {
      switch (controller.state.value) {
        case LoaderState.loading:
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );

        case LoaderState.empty:
          return Center(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No notifications found',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.loadNotification,
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            ),
          );

        case LoaderState.failure:
          return Center(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Failed to load notifications',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.loadNotification,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );

        case LoaderState.loaded:
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: _notificationList(),
          );

        case LoaderState.initial:
          return const SizedBox.shrink();
      }
    });
  }

  Widget _notificationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: controller.notifications.value.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications.value[index];
            return GestureDetector(
              onTap: () {
                print('Notification ${notification.notificationId} clicked');
              },
              child: _buildNotificationTile(notification),
            );
          },
        )),
      ],
    );
  }

  Widget _buildNotificationTile(NotificationModel notification) {
    //final title = NotificationController().changeTitle(notification.notificationType.toString());
    final date = DateTime.parse(notification.dateCreated);
    final formattedDate = "${date.day}/${date.month}/${date.year}";

    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 16),
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.notifications_none_outlined,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.notificationType.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  notification.message,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Tarikh: $formattedDate",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}