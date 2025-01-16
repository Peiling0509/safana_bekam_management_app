import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';
import 'package:safana_bekam_management_app/controller/treatment/treatment_controller.dart';
import 'package:safana_bekam_management_app/data/model/user/user_roles_model.dart';
import 'package:safana_bekam_management_app/widget/confirm_dialog.dart';
import 'package:safana_bekam_management_app/widget/custom_button.dart';
import 'package:safana_bekam_management_app/widget/custom_datetime_picker_field.dart';
import 'package:safana_bekam_management_app/widget/custom_dropdown_field.dart';
import 'package:safana_bekam_management_app/widget/custome_textfield.dart';

class TreatmentForm extends StatefulWidget {
  const TreatmentForm({super.key});

  @override
  State<TreatmentForm> createState() => _TreatmentFormState();
}

class _TreatmentFormState extends State<TreatmentForm> {
  final controller = Get.find<TreatmentController>();
  final authController = Get.find<AuthController>();
  late bool isReadOnly;

  @override
  void initState() {
    super.initState();
    //if in edited mode
    // if (controller.isEditMode()) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     controller.loadTreatmentDetails();
    //   });
    // }
    isReadOnly =
        !authController.canPerformAction(action: userAction.editTreatment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // Use resizeToAvoidBottomInset to handle keyboard
      resizeToAvoidBottomInset: true,
      body: Container(
        height: Get.height,
        padding: const EdgeInsets.all(16.0),
        // Add SingleChildScrollView as the first wrapper
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header section
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  controller.isEditMode()
                      ? "Kemas Kini Rawatan"
                      : 'Rawatan Baru',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Wrap ListView with Expanded and add SingleChildScrollView
            Expanded(
              child: SingleChildScrollView(
                // Enable keyboard dismiss when tapping outside
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    Obx(() => CustomDateTimePickerField(
                        readOnly: isReadOnly,
                        label: "Tarikh",
                        getter: controller.getCreatedData,
                        setter: (e) => controller.setCreatedData = e)),
                    Obx(
                      () => CustomDropdownField(
                        label: "Pakej",
                        items: controller.package,
                        initialValue: controller.getPackage != ""
                            ? controller.getPackage
                            : '--Pilih--',
                        onChanged: (String value) {
                          if (value == '--Pilih--') return;
                          controller.setPackage = value;
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => CustomTextField(
                              readOnly: isReadOnly,
                              label: "BP",
                              hintText: "Sebelum",
                              getter: controller.getBloodPressureBefore,
                              setter: (e) =>
                                  controller.setBloodPressureBefore = e)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() => CustomTextField(
                              readOnly: isReadOnly,
                              label: "",
                              hintText: "Selepas",
                              getter: controller.getBloodPressureAfter,
                              setter: (e) =>
                                  controller.setBloodPressureAfter = e)),
                        ),
                      ],
                    ),
                    Obx(() => CustomTextField(
                        onTap: () {
                          controller.navigateToRemark();
                        },
                        readOnly: true,
                        label: "Catatan",
                        hintText: "--Pilih--",
                        getter: controller.getRemarks
                            .where((e) => e.acupoint!.isNotEmpty)
                            .map((e) => e.bodyPart)
                            .join(', '),
                        setter: null)),
                    Obx(() => CustomTextField(
                        readOnly: isReadOnly,
                        label: "Masalah Kesihatan",
                        maxLines: 5,
                        getter: controller.getHealthComplications,
                        setter: (e) => controller.setHealthComplications = e)),
                    // Obx(() => CustomDropdownField(
                    //     label: "Juruterapi",
                    //     items: controller.juruterapi
                    //         .map((e) => e['name'] as String)
                    //         .toList(),
                    //     initialValue: controller.juruterapi.firstWhere(
                    //         (element) =>
                    //             element['id'] == controller.getTherapistId,
                    //         orElse: () => {'name': '--Pilih--'})['name']!,
                    //     onChanged: (String value) {
                    //       final selectedTherapist = controller.juruterapi
                    //           .firstWhere(
                    //               (element) => element['name'] == value);
                    //       controller.setTherapistId = selectedTherapist['id']!;
                    //     })),
                    Obx(() => CustomTextField(
                        readOnly: isReadOnly,
                        label: "Komen",
                        maxLines: 5,
                        getter: controller.getComments,
                        setter: (e) => controller.setComments = e)),
                    
                  ],
                ),
              ),
            ),
            if (authController.canPerformAction(
                action: userAction.addTreatment))
              Visibility(
                visible: !controller.isEditMode(),
                child: CustomButton(
                  title: 'Simpan',
                  onPressed: () {
                    Get.dialog(
                      ConfirmDialog(
                        title: "Simpan Rawatan",
                        content: 'Adakah anda pastikan simpan rawatan baru ?',
                        onConfirm: () async {
                          await controller.submitTreatment().then((value) {
                            //close the confirm dialog
                            Get.back();
                            //close the treatment form
                            Get.back();
                            controller.loadTreatments();
                          });
                          //Get.back();
                        },
                      ),
                    );
                  },
                ),
              ),
            if (authController.canPerformAction(
                action: userAction.editTreatment))
              Visibility(
                visible: controller.isEditMode(),
                child: CustomButton(
                  title: 'Kemas kini',
                  onPressed: () {
                    Get.dialog(
                      ConfirmDialog(
                        title: "Kemas Kini Rawatan",
                        content:
                            'Adakah anda pastikan kemas kini rawatan ini ?',
                        onConfirm: () async {
                          await controller.updateTreatment().then((value) {
                            //close the confirm dialog
                            Get.back();
                            //close the treatment form
                            Get.back();
                            controller.loadTreatments();
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            CustomButton(
              backgroundColor: Colors.red,
              title: 'Tutup',
              onPressed: () {
                if (authController.canPerformAction(
                    action: userAction.editTreatment)) {
                  Get.dialog(
                    ConfirmDialog(
                      title: 'Tutup',
                      content:
                          'Adakah anda pastikan tutup, data yang tidak disimpan akan hilang.',
                      onConfirm: () async {
                        controller.resetTreatment();
                        //close confirm dialog
                        Get.back();
                        //close treatment form
                        Get.back();
                      },
                    ),
                  );
                } else {
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
