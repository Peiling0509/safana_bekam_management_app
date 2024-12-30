import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/components/add_customer_form_top_bar.dart';
import 'package:safana_bekam_management_app/screen/patient/add_customer_form_B.dart';
import 'package:safana_bekam_management_app/widget/custome_textfield.dart';

class AddCustomerFormScreen extends StatefulWidget {
  const AddCustomerFormScreen({super.key});

  @override
  State<AddCustomerFormScreen> createState() => _AddCustomerFormScreenState();
}

class _AddCustomerFormScreenState extends State<AddCustomerFormScreen> {
  // Move the state variable inside the State class
  bool isMale = true;
  String selectedRace = '--Pilih--';
  String selectedState = '--Pilih--';
  bool isDropdownOpen = false;
  final LayerLink _layerLinkRaces = LayerLink();
  final LayerLink _layerlinkStates = LayerLink();
  OverlayEntry? _overlayEntry;

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

  @override
  void dispose() {
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
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: ConstantColor.backgroundColor,
      child: Center(
        child: Column(children: [
          const AddCustomerFormTopBar(),
          Expanded(child: _content())
        ]),
      ),
    )));
  }

  Widget _content() {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
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
          const CustomTextField(label: "Nama Penuh", getter: "", setter: null),
          const CustomTextField(label: "No MyKad", getter: "", setter: null),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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

              // Bangsa Drop Down List
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

          // Emel
          const CustomTextField(label: "Emel", getter: "", setter: null),

          // Alamat
          const CustomTextField(
              label: "Alamat", maxLines: 3, getter: "", setter: null),

          const SizedBox(height: 8),
          // Poskod
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: const CustomTextField(
                    label: "Poskod", vertical: 0, getter: "", setter: null),
              ),
              const SizedBox(width: 16),

              // Negeri
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
          // Perkerjaan
          const CustomTextField(label: "Perkerjaan", getter: "", setter: null),
          // No Tel
          const CustomTextField(label: "No Tel", getter: "", setter: null),
          _buildNextButton(),
        ],
      ),
    ));
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
                  });
                }),
            _buildGenderButton(
                isSelected: !isMale,
                label: "P",
                onTap: () {
                  setState(() {
                    isMale = false;
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

  Widget _buildNextButton() {
    return Padding(
      padding: EdgeInsets.only(top: 28.0),
      child: ElevatedButton(
          onPressed: () {
            Get.to(
              //Go to B section
              AddCustomerFormScreen_B(),
              //AddCustomerFormScreen(),
              fullscreenDialog: true,
              transition: Transition.noTransition,
            );
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: ConstantColor.primaryColor,
            minimumSize: Size(Get.width, 48),
          ),
          child: const Text(
            "Teruskan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )),
    );
  }
}
