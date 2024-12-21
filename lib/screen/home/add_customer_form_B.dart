import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/add_customer_form_top_bar.dart';
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
        child: Column(children: [const AddCustomerFormTopBar(), Expanded(child:_content())]),
      ),
    )));
  }


  Widget _content() {
    return Container(
      child: Text("This is screen B"),
    );
  }
}