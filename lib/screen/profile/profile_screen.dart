import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    final userInfo = auth.getUserInfo()!;
    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
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
                            onPressed: () => Get.toNamed("/notifications"),
                            icon: const Icon(
                              Icons.notifications_outlined,
                              size: 30,
                              color: Colors.white,
                            )),
                        const Spacer(),
                        IconButton(
                            onPressed: () => auth.logout(),
                            icon: const Icon(
                              Icons.logout_outlined,
                              size: 30,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    //Profile picture
                    const Text(
                      'Profil',
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
                        backgroundImage:
                            NetworkImage(userInfo.profilePicture ?? ""),
                        foregroundImage: AssetImage(AssetPath.imageNoFound),
                        onBackgroundImageError: (exception, stackTrace) =>
                            throw NetworkImageLoadException,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userInfo.username ?? "null",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userInfo.email ?? "null",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 25)
                  ],
                ),
              ),
              Positioned(
                top: 1,
                right: 1,
                child: IgnorePointer(
                  ignoring: true,
                  child: Image.asset(
                    height: 200,
                    width: 200,
                    AssetPath.backgroundCircle,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: _buildEditButton(() => Get.toNamed("/edit_profile")),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        _buildUserInfoTitle(
                            title: "Perana",
                            info: userInfo.role != null
                                ? userInfo.role!.join(", ")
                                : "null"),
                        _buildUserInfoTitle(
                            title: "Name", info: userInfo.username ?? "null"),
                        _buildUserInfoTitle(
                            title: "Email", info: userInfo.email ?? "null"),
                        _buildUserInfoTitle(
                            title: "No Tel", info: userInfo.mobileNo ?? "null"),
                        _buildUserInfoTitle(
                            title: "Alamat", info: userInfo.address ?? "null"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEditButton(Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 35,
        width: 70,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstantColor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
            ),
            child: const Icon(Icons.edit)),
      ),
    );
  }

  Widget _buildUserInfoTitle({required String title, required String info}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(
            info,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
