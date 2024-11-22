import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

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
                height: 130,
                fit: BoxFit.cover,
              )),
              const SizedBox(height: 20),
              Text(
                "Login",
                style: TextStyle(fontSize: 25, color: ConstantColor.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
