import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
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
    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
              _textfieldUserName(),
              _textfieldPassword(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                    isError: true,
                    tristate: true,
                    activeColor: ConstantColor.primaryColor,
                    value: controller.isRememberMe(),
                    onChanged: (bool? value) {
                      setState(() {
                        controller.setRememberMe(value ?? false);
                      });
                    },
                  ),
                  Text(
                    'Ingat Saya',
                    style: TextStyle(color: ConstantColor.primaryColor),
                  )
                ],
              ),
              _buildButton('LOG MASUK', () => controller.submit()),
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
        height: 50,
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
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                  controller:
                      TextEditingController(text: controller.getUsername ?? ""),
                  onChanged: (text) {
                    controller.setUsername = text;
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                    floatingLabelStyle:
                        TextStyle(color: ConstantColor.primaryColor),
                    suffixIcon: const Icon(Icons.person_outline),
                    suffixIconColor: Colors.grey,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: controller.usernameError.isNotEmpty
                          ? const BorderSide(width: 1, color: Colors.red)
                          : BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: ConstantColor.primaryColor, width: 2)),
                    filled: true,
                    fillColor: Colors.white,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red)),
                  ),
                ),
              ),
              if (controller.usernameError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: Text(
                    controller.usernameError.value,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ));
  }

  Widget _textfieldPassword() {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Light shadow
                        blurRadius: 5, // Softness of the shadow
                        offset: const Offset(0, 4), // Position of the shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: TextEditingController(
                        text: controller.getPassword ?? ""),
                    onChanged: (text) => controller.setPassword = text,
                    obscureText: controller.isObscuredPass.value,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: "Password",
                      floatingLabelStyle:
                          TextStyle(color: ConstantColor.primaryColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isObscuredPass.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            controller.isObscuredPass.value =
                                !controller.isObscuredPass.value;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        borderSide: controller.passwordError.isNotEmpty
                            ? const BorderSide(width: 1, color: Colors.red)
                            : BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: ConstantColor.primaryColor, width: 2)),
                      filled: true,
                      fillColor: Colors.white,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red)),
                    ),
                  )),
              if (controller.passwordError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: Text(
                    controller.passwordError.value,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ));
  }
}
