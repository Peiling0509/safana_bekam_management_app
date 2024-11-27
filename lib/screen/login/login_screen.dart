import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/custom_loading_dialog.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/controller/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final controller = Get.find<LoginController>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AssetPath.backgroundApp),
                  fit: BoxFit.cover)),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                AssetPath.logo,
                height: 100,
                fit: BoxFit.cover,
              )),
              const SizedBox(height: 20),
              // Text(
              //   "Login",
              //   style:
              //       TextStyle(fontSize: 25, color: ConstantColor.primaryColor),
              // ),
              //text field for username
              _textfieldUserName(),

              _textfieldPassword(),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => CustomLoadingDialog.hide(context),
                      child: Text('Forgot password ?'))
                ],
              ),

              _buildButton(
                  'LOGIN',
                  () => CustomLoadingDialog.show(context,
                      message: 'Please wait...'))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: Get.width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: ConstantColor.primaryColor, // Button color
            foregroundColor: Colors.white, // Text color
            padding: const EdgeInsets.symmetric(
              horizontal: 40, // Horizontal padding
              vertical: 15, // Vertical padding
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _textfieldUserName() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Light shadow
              blurRadius: 10, // Softness of the shadow
              offset: const Offset(0, 4), // Position of the shadow
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Username',
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: const Icon(Icons.person_outline),
            suffixIconColor: Colors.grey,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _textfieldPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Light shadow
                blurRadius: 10, // Softness of the shadow
                offset: const Offset(0, 4), // Position of the shadow
              ),
            ],
          ),
          child: Obx(
            () => TextField(
              obscureText: controller.isObscuredPass.value,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isObscuredPass.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined, // Toggles the icon
                  ),
                  color: Colors.grey,
                  onPressed: () {
                    setState(() {
                      controller.isObscuredPass.value =
                          !controller.isObscuredPass.value; // Toggle state
                    });
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          )),
    );
  }
}
