import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final int maxLines;
  final double vertical;
  final bool readOnly;
  final Function()? onTap;
  final String getter;
  final Function(String)? setter;
  const CustomTextField(
      {super.key,
      this.hintText,
      this.maxLines = 1,
      this.vertical = 8.0,
      this.readOnly = false,
      this.onTap,
      required this.label,
      required this.getter,
      required this.setter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            readOnly: readOnly,
            onTap: onTap,
            onChanged: (value) => setter,
            controller: TextEditingController(text: getter),
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.blueGrey),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: ConstantColor.primaryColor)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }
}
