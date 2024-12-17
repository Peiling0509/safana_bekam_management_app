import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  final String userName;
  final String lastLoginTime;
  final VoidCallback onNotificationTap;
  final VoidCallback onLogoutTap;

  const TopBar({
    super.key,
    required this.userName,
    required this.lastLoginTime,
    required this.onNotificationTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  onTap: onNotificationTap,
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
                  onTap: onLogoutTap,
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
              "Hai, $userName",
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
              "Log Masuk Terakhir: $lastLoginTime",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
