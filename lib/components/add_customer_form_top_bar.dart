import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class AddPatientFormTopBar extends StatelessWidget{
  final String title;

  const AddPatientFormTopBar({
    super.key,
    required this.title,
  });

  @override 
  Widget build(BuildContext context) {
    return Container(
      color: ConstantColor.primaryColor,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){ 
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 28,
                  )),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 28),
              )
            ],
          )),
    );
  } 
}
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
