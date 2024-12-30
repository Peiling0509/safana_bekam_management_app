import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/data/model/treatment/treatment_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header section
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5), // Space for the handle
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10), // Space below the handle
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
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                CustomDateTimePickerField(label: "Tarikh", setter: (e) => null),
                CustomDropdownField(
                  label: "Pakej",
                  items: TreatmentModel().pakej,
                  initialValue: '--Pilih--',
                  onChanged: (String value) {
                    print('Selected: $value');
                    // Handle the selection
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          label: "BP",
                          hintText: "Sebelum",
                          getter: "",
                          setter: null),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                          label: "",
                          hintText: "Selepas",
                          getter: "",
                          setter: null),
                    ),
                  ],
                ),
                CustomTextField(
                    onTap: () => Get.toNamed("/remark"),
                    readOnly: true,
                    label: "Catatan",
                    hintText: "--Pilih---",
                    getter: "",
                    setter: null),
                CustomTextField(
                    label: "Masalah Kesihatan",
                    maxLines: 5,
                    getter: "",
                    setter: null),
                CustomDropdownField(
                  label: "Juruterapi",
                  items: TreatmentModel().juruterapi,
                  initialValue: '--Pilih--',
                  onChanged: (String value) {
                    print('Selected: $value');
                    // Handle the selection
                  },
                ),
                const SizedBox(height: 18),
               
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: CustomButton(
                    title: 'Simpan',
                    onPressed: () => null,
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: CustomButton(
                    title: 'Tutup',
                    onPressed: () => Get.back(),
                    backgroundColor: Colors.grey,
                    foregroundColor: ConstantColor.primaryColor,
                  ),
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
