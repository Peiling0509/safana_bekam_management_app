import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';
import 'package:safana_bekam_management_app/widget/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final userInfo = auth.getUserInfo()!;
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
                                NetworkImage(userInfo.profilePicture ?? ""),
                            foregroundImage: AssetImage(AssetPath.imageNoFound),
                            onBackgroundImageError: (exception, stackTrace) =>
                                throw NetworkImageLoadException,
                          ),
                          // Edit Icon
                          Positioned(
                            bottom: 5, // Slight padding from the bottom.
                            right: 5, // Slight padding from the right.
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors
                                    .red, // Background color for contrast.
                              ),
                              padding: const EdgeInsets.all(
                                  10), // Inner padding around the icon.
                              child: Icon(
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
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                        labelText: "Username", inputText: userInfo.username),
                    _buildTextField(
                        labelText: "Email", inputText: userInfo.email),
                    _buildTextField(
                        labelText: "No Tel", inputText: userInfo.mobileNo),
                    _buildTextField(
                        labelText: "Alamat", inputText: userInfo.address),
                    const SizedBox(height: 10),
                    CustomButton(title: "SIMPAN", onPressed:(){},)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String labelText, required String? inputText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          controller: TextEditingController(text: inputText ?? ""),
          onChanged: (text) {
            //controller.setUsername = text;
          },
          decoration: InputDecoration(
            labelText: labelText,
            floatingLabelStyle: TextStyle(color: ConstantColor.primaryColor),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: ConstantColor.primaryColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: ConstantColor.primaryColor, width: 2)),
            filled: true,
            fillColor: Colors.white,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        ),
      ),
    );
  }
}
