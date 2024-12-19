import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.title,
      required this.onPressed});

  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 50,
        width: Get.width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: ConstantColor.primaryColor,
             foregroundColor: Colors.white, // Te
            padding: const EdgeInsets.symmetric(
              horizontal: 40, // Horizontal padding
              vertical: 15, // Vertical padding
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
