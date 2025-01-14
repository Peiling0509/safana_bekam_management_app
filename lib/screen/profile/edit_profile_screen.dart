import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';
import 'package:safana_bekam_management_app/widget/custom_button.dart';
import 'package:safana_bekam_management_app/widget/custome_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                    Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                    const Text(
                      'Edit Profil',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(controller.getProfilePicture),
                            foregroundImage: AssetImage(AssetPath.imageNoFound),
                            onBackgroundImageError: (exception, stackTrace) =>
                                throw NetworkImageLoadException,
                          ),
                          // Edit Icon
                          Positioned(
                            bottom: 5, // Slight padding from the bottom.
                            right: 5, // Slight padding from the right.
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors
                                    .red, // Background color for contrast.
                              ),
                              padding: const EdgeInsets.all(
                                  10), // Inner padding around the icon.
                              child: const Icon(
                                Icons.image,
                                size: 20, // Icon size.
                                color: Colors.white, // Icon color.
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Muat naik gambar profil anda",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Obx(
                        () => CustomTextField(
                            label: "Username",
                            hintText: "Masukkan username",
                            getter: controller.getUsername,
                            setter: (value) => controller.setUsername = value),
                      ),
                      Obx(
                        () => CustomTextField(
                            label: "Email",
                            hintText: "Masukkan email",
                            getter: controller.getEmail,
                            setter: (value) => controller.setEmail = value),
                      ),
                      Obx(
                        () => CustomTextField(
                            label: "No Tel",
                            hintText: "Masukkan no tel",
                            getter: controller.getMobileNo,
                            setter: (value) => controller.setMobileNo = value),
                      ),
                      Obx(
                        () => CustomTextField(
                            maxLines: 5,
                            label: "Alamat",
                            hintText: "Masukkan alamat",
                            getter: controller.getAddress,
                            setter: (value) => controller.setAddress = value),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomButton(
                  title: "SIMPAN",
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
