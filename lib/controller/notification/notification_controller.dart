import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/toast.dart';
import 'package:safana_bekam_management_app/data/model/notification/notifications_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';
import 'package:safana_bekam_management_app/data/respository/notification_repository.dart';

class NotificationController extends GetxController{
  final Rx<LoaderState> state = LoaderState.initial.obs;

  final repository = NotificationRepository();
  Rx<List<NotificationModel>> notifications = Rx<List<NotificationModel>>([]);

  loadNotification() async {
    try {
      state.value = LoaderState.loading;
       final data = await repository.loadNotification();
        if (data.isEmpty || data == []) {
          return state.value = LoaderState.empty;
        }
        notifications.value = data;
      state.value = LoaderState.loaded;
    } catch (e) {
      toast("Error loading notifications");
      print('Error loading notification: ${e.toString()}');
      state.value = LoaderState.failure;
    }
  }

  changeTitle(String notification) async {
    if(notification == "patient submission")
    {
      return "Tambah Pelanggan Berjaya";
    } else if(notification == "treatment submission")
    {
      return "Rekod Rawatan Baharu";
    } else {
      return notification;
    }
  }
}