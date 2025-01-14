import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/toast.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/components/add_customer_form_top_bar.dart';
import 'package:safana_bekam_management_app/controller/patient/patient_controller.dart';
import 'package:safana_bekam_management_app/components/custom_check_box.dart';
import 'package:safana_bekam_management_app/data/model/patients/medical_history_model.dart';
import 'package:safana_bekam_management_app/data/model/patients/patients_model.dart';
import 'package:safana_bekam_management_app/data/model/shared/checkbox_type.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';

class UpdatePatientScreen extends StatefulWidget {
  //final String customerId;

  const UpdatePatientScreen({
    super.key,
    //required this.customerId,
  });

  @override
  State<UpdatePatientScreen> createState() => _UpdatePatientScreenState();
}

class _UpdatePatientScreenState extends State<UpdatePatientScreen> {
  final PatientController patientController = Get.put(PatientController());

  //Form A
  final fullNameController = TextEditingController();
  final myKadController = TextEditingController();
  final mobileNoController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final postcodeController = TextEditingController();
  final occupationController = TextEditingController();

  // Move the state variable inside the State class
  bool isMale = true;
  String selectedRace = '--Pilih--';
  String selectedState = '--Pilih--';

  bool isDropdownOpen = false;
  final LayerLink _layerLinkRaces = LayerLink();
  final LayerLink _layerlinkStates = LayerLink();
  OverlayEntry? _overlayEntry;

  bool hasUserModifiedFields = false;

  //This is the list for kaum, add more as needed
  final List<String> races = [
    '--Pilih--',
    'Malay',
    'Cina',
    'Bidayuh',
    'Lain-lain',
  ];

  final List<String> states = [
    '--Pilih--',
    'Sarawak',
    'Sabah',
    'Selangor',
    'Penang',
    'Johor',
    'Lain-lain',
  ];

  //Form B
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
    'Gout': false,
    'Masalah Hati': false,
    'Masalah buah pinggang': false,
    'Masalah Tulang belakang & Saraf': false,
    'Masalah Pendarahan': false,
    'Pembedahan': false,
  };

  final Map<String, TextEditingController> _controllers = {};

  

  // This function will be called to prefill the data when the screen is loaded
  @override
  void initState() {
    super.initState();
    // Initialize controllers for all checkboxes
    for (var key in _checkboxStates.keys) {
      _controllers[key] = TextEditingController();
    }

    // Load patient data after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dynamic arguments = Get.arguments;
      if (arguments is String && arguments.isNotEmpty) {
        patientController.loadPatientDetails(arguments).then((_) {
          _loadMedicalHistory();
        });
      }
    });
  }

  void _loadMedicalHistory() {
    final patient = patientController.currentPatient.value;
    if (patient != null && patient.medicalHistory != null) {
      setState(() {
        // Reset all checkboxes first
        _checkboxStates.updateAll((key, value) => false);
        
        // Update checkboxes and controllers based on medical history
        for (var history in patient.medicalHistory) {
          if (history.condition != null && _checkboxStates.containsKey(history.condition)) {
            _checkboxStates[history.condition!] = true;
            if (_controllers.containsKey(history.condition)) {
              _controllers[history.condition]!.text = history.medicine ?? '';
            }
          }
        }
      });
    }
  }

  @override
  void dispose() {
    // Dispose of all controllers
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _overlayEntry?.remove();
    super.dispose();
  }

  void _showDropdown(List<String> list, LayerLink layerlink, String type) {
    final overlay = Overlay.of(context);

    _overlayEntry = _createOverlayEntry(list, layerlink, type);
    overlay.insert(_overlayEntry!);
    setState(() {
      isDropdownOpen = true;
    });
  }

  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      isDropdownOpen = false;
    });
  }

  void _handleSelection(String value, String type) {
    setState(() {
      if (type == 'race') {
        selectedRace = value;
      } else if (type == 'state') {
        selectedState = value;
      }
      hasUserModifiedFields = true;
    });
    _hideDropdown();
  }

//This is used for the overlaying drop down list
  OverlayEntry _createOverlayEntry(
      List<String> list, LayerLink layerlink, String type) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: layerlink.leaderSize?.width,
        child: CompositedTransformFollower(
          link: layerlink,
          showWhenUnlinked: false,
          offset: Offset(0, 48),
          child: Material(
            borderRadius: BorderRadius.circular(15),
            elevation: 0,
            color: Colors.amber,
            child: Container(
              //height = size of an option * number of options displayed
              height: 48.0 * 4,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
                color: ConstantColor.backgroundColor,
              ),
              //Scrollable within the drop down list
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SingleChildScrollView(
                  //clipBehavior: Clip.none,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: list.map((String item) {
                      bool isSelected = type == 'race'
                          ? item == selectedRace
                          : item == selectedState;
                      return InkWell(
                        onTap: () => _handleSelection(item, type),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ConstantColor.primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          child: Center(
                            child: Text(
                              item,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : (item == '--Pilih--'
                                        ? Colors.grey
                                        : Colors.black),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // Clear all checkboxes and text controllers
    // _checkboxStates.updateAll((key, value) => false);
    // for (var controller in _controllers.values) {
    //   controller.dispose();
    // }
    // _controllers.clear();


    return Scaffold(
        body: SafeArea(
            child: Container(
      color: ConstantColor.backgroundColor,
      child: Center(
        child: Column(children: [
          Container(
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
                    Center(
                      child: Text(
                        "Maklumat Pelangan",
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
          ),
          Expanded(child: _content())
        ]),
      ),
    )));
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
                  _buildFormA(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Divider(
                      thickness: 3,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                  _buildFormB(),
                ],
              ))
        ],
      ),
    );
  }

//Here is buildFormA
  Widget _buildFormA() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "A. Maklumat Pelangan",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Obx(() {
          // Observe the patientDetails for changes
          // var patient = patientController.currentPatient.value;
          //this is one of the dummy data
          var patient = patientController.currentPatient.value;
          if (patient != null) {
            // Pre-fill the form fields when the data is available
            fullNameController.text = patient.name ?? '';
            myKadController.text = patient.myKad ?? '';
            mobileNoController.text = patient.mobileNo ?? '';
            emailController.text = patient.email ?? '';
            addressController.text = patient.address ?? '';
            postcodeController.text = patient.postcode ?? '';
            occupationController.text = patient.occupation ?? '';
            //selectedRace = patient.ethnicity ?? '--Pilih--';
            //selectedState = patient.state ?? '--Pilih--';
            //isMale = patient.gender == 'Male';

            // Set the values only if they haven't been modified by user
            if (!hasUserModifiedFields) {
              selectedRace = patient.ethnicity ?? '--Pilih--';
              selectedState = patient.state ?? '--Pilih--';
              isMale = patient.gender == 'Male';
            }
          }
          return Column(
            children: [
              _buildTextField("Nama Penuh", controller: fullNameController),
              _buildTextField("No MyKad", controller: myKadController),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Jantina",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildGenderSelection(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bangsa",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                            races, _layerLinkRaces, selectedRace, 'race'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField("Emel", controller: emailController),
              _buildTextField("Alamat",
                  controller: addressController, maxLines: 3),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField("Poskod",
                          controller: postcodeController)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Negeri",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                            states, _layerlinkStates, selectedState, 'state'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildTextField("Perkerjaan", controller: occupationController),
              _buildTextField("No Tel", controller: mobileNoController),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildDropdown(
      List<String> list, LayerLink layerlink, String selected, String type) {
    return CompositedTransformTarget(
      link: layerlink,
      child: InkWell(
        onTap: () {
          if (isDropdownOpen) {
            _hideDropdown();
          } else {
            _showDropdown(list, layerlink, type);
          }
        },
        child: Container(
          //item height
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selected,
                style: TextStyle(
                  color: selected == '--Pilih--' ? Colors.grey : Colors.black,
                  fontSize: 16,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildGenderButton(
                isSelected: isMale,
                label: 'L',
                onTap: () {
                  setState(() {
                    isMale = true;
                    hasUserModifiedFields = true;
                  });
                }),
            _buildGenderButton(
                isSelected: !isMale,
                label: "P",
                onTap: () {
                  setState(() {
                    isMale = false;
                    hasUserModifiedFields = true;
                  });
                })
          ],
        ));
  }

  Widget _buildGenderButton({
    required bool isSelected,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? ConstantColor.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label,
      {required TextEditingController controller, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  //Here is buildFormB
   Widget _buildFormB() {
    return Obx(() {
      final patient = patientController.currentPatient.value;
      if (patient == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
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
          _buildCheckBoxListTile(),
          _buildSubmitButton(),
          _buildDeleteButton()
        ],
      );
    });
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

                        // Clear the text field if unchecked
                        if (!value) {
                          _controllers[key]?.clear();
                        }
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
                    decoration: InputDecoration(
                      hintText: 'Pengambilan Ubat',
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.3)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey)),
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
            //openDialog();
            String? patientId = Get.arguments as String?;
            //handle form A
            patientController.updatePatientInfo(
              name: fullNameController.text,
              myKad: myKadController.text,
              gender: isMale ? "Male" : "Female",
              ethnicity: selectedRace == '--Pilih--' ? '' : selectedRace,
              mobileNo: mobileNoController.text,
              email: emailController.text,
              postcode: postcodeController.text,
              state: selectedState == '--Pilih--' ? '' : selectedState,
              address: addressController.text,
              occupation: occupationController.text,
            );

            //clear existing history
            patientController.clearMedicalHistory();

            //handle form B
            _checkboxStates.forEach((condition, isChecked) {
              if (isChecked) {
                patientController.addMedicalHistory(
                  condition,
                  _controllers[condition]?.text ?? "",
                );
              }
            });

            print("---------------------------------------------------------------------------------------------This is a test: ${patientController.currentPatient.value.medicalHistory.length}");

            
            //submit patient data
            patientController.updatePatient(patientId);

            // Clear the cached patient data
            patientController.clearCurrentPatient();

            // Reset the modification flag
            hasUserModifiedFields = false;

            Get.back();
            Get.back();
            patientController.loadPatients();

            print("submit button clicked");
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: ConstantColor.primaryColor,
            minimumSize: Size(Get.width, 48),
          ),
          child: const Text(
            "Kemas Kini",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )),
    );
  }

  Widget _buildDeleteButton() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: ElevatedButton(
          onPressed: () {
            //show pop up
            openDialog();
            print("delete button clicked");
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Colors.red,
            minimumSize: Size(Get.width, 48),
          ),
          child: const Text(
            "Delete",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )),
    );
  }

  //This is for delete button
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
                    "Confirm Delete?",
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
                          
                          //delete patient by id
                          patientController.deletePatient(patientController.currentPatient.value.id.toString()),
                          //patientController.loadPatients(),
                          Get.back(),
                          Get.back(),
                          Get.back(),
                          patientController.loadPatients(),
                          //patientController.currentPatient.refresh()
                          //Navigator.pop(context),
                          //openSuccessDialog()
                        },
                        child: Container(
                          width: Get.width * 0.32,
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              //border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red),
                          child: const Text(
                            "Delete",
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
}
