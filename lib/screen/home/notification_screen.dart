import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              color: ConstantColor.primaryColor,
              child: Center(
                  child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
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

                          const Center(
                            child: Text(
                              "Notis",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                                //letterSpacing: 1,
                              ),
                            ),
                          ),

                          //this padding is to center the text
                          //the padding size is equal to the icon size
                          const Padding(
                            padding: EdgeInsets.only(right: 28),
                          )
                        ],
                      )),

                      const Padding(padding: EdgeInsets.only(bottom: 20)),

                      Expanded(
                      child: SingleChildScrollView(
                          //padding: const EdgeInsets.only(top: 20),
                          child: _notificationList()),
                    ),
                ],
              )))),
    );
  }

  Widget _notificationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: 13,
          itemBuilder: (context, index) {
            final name = index == 12 ? 'Last' : 'Notification $index';
            return GestureDetector(
              onTap: () {
                // Handle customer tile click
                print('Notification $name clicked');
              },
              child: _buildNotificationTile(name),
            );
          },
        ),
      ],
    );
  }

Widget _buildNotificationTile(String name) {
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
        const SizedBox(width: 16), // Spacing on the left
        const CircleAvatar(
          backgroundColor: Colors.white, // Background for the icon
          child: Icon(
            Icons.notifications_none_outlined,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 16), // Space between the icon and text
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              //subtitle
              Text("Nama Pelanggan & No IC",
              style: TextStyle( 
                color: Colors.black.withOpacity(0.4),
              ),),

              Text("Tarikh: 13/10/2024",
              style: TextStyle( 
                color: Colors.black.withOpacity(0.4)
              ),),
            ],
          ),
        ),
        const SizedBox(width: 16), // Spacing on the right
      ],
    ),
  );
}
}