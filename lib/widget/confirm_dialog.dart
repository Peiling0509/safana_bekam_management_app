import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class ConfirmDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? confirmText;
  final String? cancelText;
  final Function()? onConfirm;
  final Function? onCancel;

  const ConfirmDialog({
    super.key,
    this.title,
    this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SingleChildScrollView(
        child: SizedBox(
          width: Get.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  content!,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: Get.width * 0.32,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          "Batal",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onConfirm,
                      child: Container(
                        width: Get.width * 0.32,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            //border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                            color: ConstantColor.primaryColor),
                        child: const Text(
                          "Sahkan",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
