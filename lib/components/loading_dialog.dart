import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class LoadingDialog {
  static void show({String message = 'Loading...'}) {
    Get.dialog(Dialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      backgroundColor: Colors.transparent,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: Get.width * 0.32,
          height: Get.height * 0.12,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: ConstantColor.primaryColor,
                strokeWidth: 4,
              ),
              const SizedBox(height: 15),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ));
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //       insetPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    //       backgroundColor: Colors.transparent,
    //       child: Align(
    //         alignment: Alignment.center,
    //         child: Container(
    //           width: Get.width * 0.32,
    //           height: Get.height * 0.12,
    //           decoration: BoxDecoration(
    //               color: Colors.white, borderRadius: BorderRadius.circular(15)),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               CircularProgressIndicator(
    //                 color: ConstantColor.primaryColor,
    //                 strokeWidth: 4,
    //               ),
    //               const SizedBox(height: 15),
    //               Text(
    //                 message,
    //                 style: const TextStyle(
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.black87,
    //                 ),
    //                 textAlign: TextAlign.center,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
