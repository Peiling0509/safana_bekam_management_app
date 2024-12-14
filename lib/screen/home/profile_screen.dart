import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: Get.width,
              //height: Get.height / 3,
              decoration: BoxDecoration(
                  color: ConstantColor.primaryColor,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              child: Column(
                children: [
                  //App Bar
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.notifications_outlined,
                            size: 30,
                            color: Colors.white,
                          )),
                      Spacer(),
                      IconButton(
                          onPressed:() => AuthController().logout(),
                          icon: Icon(
                            Icons.logout_outlined,
                            size: 30,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  //Profile picture
                  const Text(
                    'Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('User Name', style: TextStyle(color: Colors.white, fontSize: 18),),
                  const SizedBox(height: 5),
                  Text('email@email.com', style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300, ),),
                  const SizedBox(height: 25)
                ],
              ),
            ),
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,), ),
                  Text('Ali')
                ],
              ),
            )
          
          ],
        ),
      ),
    );
  }
}
