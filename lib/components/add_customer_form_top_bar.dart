import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class AddCustomerFormTopBar extends StatelessWidget{

  const AddCustomerFormTopBar({
    super.key,
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
              const Center(
                child: Text(
                  "Maklumat Pelanggan Baru",
                  style: TextStyle(
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