import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/add_customer_form_top_bar.dart';
import 'package:safana_bekam_management_app/components/custom_check_box.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/data/model/shared/checkbox_type.dart';
import 'package:safana_bekam_management_app/controller/patient/patient_controller.dart';

class AddPatientFormScreen_B extends StatefulWidget {
  const AddPatientFormScreen_B({super.key});

  @override
  State<AddPatientFormScreen_B> createState() =>
      _AddPatientFormScreen_B_State();
}

class _AddPatientFormScreen_B_State extends State<AddPatientFormScreen_B> {
  final PatientController patientController = Get.find<PatientController>();

  final Map<String, bool> _checkboxStates = {
    'Kencing Manis': false,
    'Darah Tinggi': false,
    'Darah Rendah': false,
    'Masalah Jantung': false,
    'Kanser & Ketumbukan': false,
    'AIDS / Pembawa HIV': false,
    'Sebarang Penyakit Berkaitan Darah': false,
    'Sebarang Penyakit Berjangkit': false,
    'Takut Darah': false,
    'Migrain': false,
    'Kolestrol': false,
    'Gastrik': false,
    'Gout': false,
    'Masalah Hati': false,
    'Masalah buah pinggang': false,
    'Masalah Tulang belakang & Saraf': false,
    'Masalah Pendarahan': false,
    'Pembedahan': false,
    'Lain-lain': false,
  };

  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (var key in _checkboxStates.keys) {
      _controllers[key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ConstantColor.backgroundColor,
          child: Column(
            children: [
              const AddPatientFormTopBar(
                title: "Maklumat Pelangan Baharu",
              ),
              Expanded(child: _content()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "B. LatarBelakang Kesihatan",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Tandakan ✔ jika berkenaan dan nyatakan pengambilan ubat atau pembedahan",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Divider(
                    thickness: 3,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),

                // Custom Checkbox List
                _buildCheckBoxListTile(),
                _buildSubmitButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBoxListTile() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _checkboxStates.length,
      itemBuilder: (context, index) {
        String key = _checkboxStates.keys.elementAt(index);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomCheckBox(
                    value: _checkboxStates[key] ?? false,
                    onChanged: (bool value) {
                      setState(() {
                        _checkboxStates[key] = value;
                      });
                    },
                    size: 30,
                    type: MyCheckboxType.none, // Adjust based on your needs
                    activeBgColor:
                        ConstantColor.primaryColor, // Adjust colors as needed
                    inactiveBgColor: ConstantColor.backgroundColor,
                    activeBorderColor: ConstantColor.primaryColor,
                    inactiveBorderColor: Colors.grey,
                    checkColor: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      key,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              if (_checkboxStates[key] ?? false)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: TextField(
                    controller: _controllers[key],
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: key == 'Lain-lain' 
                      ? 'Latarbelakang Kesihatan Lain'
                      : 'Pengambilan Ubat',
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.3)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.grey)),
                      filled: true,
                      fillColor: ConstantColor.backgroundColor,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.only(top: 28.0),
      child: ElevatedButton(
          onPressed: () {
            //show pop up
            openDialog();
            print("submit button clicked");
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: ConstantColor.primaryColor,
            minimumSize: Size(Get.width, 48),
          ),
          child: const Text(
            "Simpan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Container(
              width: Get.width,
              height: 115,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 30,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Sahkan?",
                    style: TextStyle(
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
                        onTap: () => {
                          Navigator.pop(context),
                        },
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
                        onTap: () => {
                          //clear existing history
                          patientController.clearMedicalHistory(),
                          //collect health background data
                          _checkboxStates.forEach((condition, isChecked) {
                            if (isChecked) {
                              patientController.addMedicalHistory(
                                condition,
                                _controllers[condition]?.text ?? "",
                              );
                            }
                          }),

                          //submit patient data
                          patientController.submitPatient(),
                          
                          // Clear the cached patient data
                          patientController.clearCurrentPatient(),

                          Navigator.pop(context), 
                          openSuccessDialog()
                          },
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
          ));

  Future openSuccessDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Container(
            width: Get.width,
            height: 115,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.mark_chat_unread_outlined,
                  size: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Tambah Pelanggan Berjaya",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                GestureDetector(
                  onTap: () => {Navigator.pop(context), Get.back(), Get.back(), Get.back(), patientController.loadPatients()},
                  child: Container(
                    width: Get.width * 0.32,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        //border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                        color: ConstantColor.primaryColor),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          )));
}
