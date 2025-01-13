import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';
import 'package:safana_bekam_management_app/screen/home/notification_screen.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
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
                      onTap: () => auth.logout(),
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
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30),
                child: Text(
                  "Hai, ${auth.getUserInfo()!.username}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: Text(
                  "Log Masuk Terakhir: ${auth.lastLoginDateTime()}",
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
