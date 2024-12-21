import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/screen/login/login_screen.dart';

class AddCustomerFormScreen_B extends StatefulWidget {
  const AddCustomerFormScreen_B({super.key});

  @override
  State<AddCustomerFormScreen_B> createState() => _AddCustomerFormScreen_B_State();
}

class _AddCustomerFormScreen_B_State extends State<AddCustomerFormScreen_B> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: ConstantColor.backgroundColor,
      child: Center(
        child: Column(children: [_topAppBar(), Expanded(child:_content())]),
      ),
    )));
  }

  //same as part A
  Widget _topAppBar() {
    return Container(
      color: ConstantColor.primaryColor,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
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

  Widget _content() {
    return Container(
      child: Text("This is screen B"),
    );
  }
}