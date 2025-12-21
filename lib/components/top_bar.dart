import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';
import 'package:safana_bekam_management_app/screen/home/notification_screen.dart';
import 'package:safana_bekam_management_app/widget/confirm_dialog.dart';

class TopBar extends StatefulWidget {
  const TopBar({
    super.key,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final controller = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setUserForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: ConstantColor.primaryColor,
          width: Get.width,
          height: 175,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      //onTap: () => Get.toNamed("/notifications"),
                      onTap: () => {
                        Get.to(
                          NotificationScreen(),
                          fullscreenDialog: true,
                          transition: Transition.leftToRight,
                        )
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.dialog(ConfirmDialog(
                        title: "Log keluar",
                        content: "Adakah anda pasti mahu log keluar ?",
                        onConfirm: () => controller.logout(),
                      )),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30),
                  child: Text(
                    "Hai, ${controller.getUsername}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: Text(
                  "Log Masuk Terakhir: ${controller.lastLoginDateTime()}",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 1,
          right: 1,
          child: IgnorePointer(
            ignoring: true,
            child: Image.asset(
              height: 160,
              width: 160,
              AssetPath.backgroundCircle,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}

// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
