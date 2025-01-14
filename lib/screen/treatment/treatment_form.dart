import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/treatment/treatment_controller.dart';
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

  @override
  void initState() {
    super.initState();
    //if in edited mode
    if (controller.getRecordId.isNotEmpty || controller.getRecordId != "") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.loadTreatmentDetails();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Wrap with Scaffold to handle keyboard better
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
                const Text(
                  'Rawatan Baru',
                  style: TextStyle(
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
                              label: "BP",
                              hintText: "Sebelum",
                              getter: controller.getBloodPressureBefore,
                              setter: (e) =>
                                  controller.setBloodPressureBefore = e)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() => CustomTextField(
                              label: "",
                              hintText: "Selepas",
                              getter: controller.getBloodPressureAfter,
                              setter: (e) =>
                                  controller.setBloodPressureAfter = e)),
                        ),
                      ],
                    ),
                    Obx(() => CustomTextField(
                        onTap: () => controller.navigateToRemark(),
                        readOnly: true,
                        label: "Catatan",
                        hintText: "--Pilih--",
                        getter: controller.getRemarks
                            .where((e) => e.acupoint!.isNotEmpty)
                            .map((e) => e.bodyPart)
                            .join(', '),
                        setter: null)),
                    Obx(() => CustomTextField(
                        label: "Masalah Kesihatan",
                        maxLines: 5,
                        getter: controller.getHealthComplications,
                        setter: (e) => controller.setHealthComplications = e)),
                    Obx(() => CustomDropdownField(
                        label: "Juruterapi",
                        items: controller.juruterapi
                            .map((e) => e['name'] as String)
                            .toList(),
                        initialValue: controller.juruterapi.firstWhere(
                            (element) =>
                                element['id'] == controller.getTherapistId,
                            orElse: () => {'name': '--Pilih--'})['name']!,
                        onChanged: (String value) {
                          final selectedTherapist = controller.juruterapi
                              .firstWhere(
                                  (element) => element['name'] == value);
                          controller.setTherapistId = selectedTherapist['id']!;
                        })),
                    Obx(() => CustomTextField(
                        label: "Komen",
                        maxLines: 5,
                        getter: controller.getComments,
                        setter: (e) => controller.setComments = e)),
                    // Add extra padding at the bottom to ensure last fields are visible
                  ],
                ),
              ),
            ),
            CustomButton(
              title: 'Simpan',
              onPressed: () {
                Get.dialog(
                  ConfirmDialog(
                    title: 'Rawatan Baru',
                    content: 'Adakah anda pastikan simpan rawatan baru ?',
                    onConfirm: () async {
                      await controller.submit().then((value) {
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
                //controller.submit();
              },
            ),
            CustomButton(
              backgroundColor: Colors.red,
              title: 'Tutup',
              onPressed: () {
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
                //controller.submit();
              },
            ),
          ],
        ),
      ),
    );
  }
}
