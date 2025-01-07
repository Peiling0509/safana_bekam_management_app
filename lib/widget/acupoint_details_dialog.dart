import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/controller/treatment/acupoint_controller.dart';
import 'package:safana_bekam_management_app/data/model/treatment/acupoint_model.dart';
import 'package:safana_bekam_management_app/widget/custom_button.dart';

class AcupointDetailsDialog extends StatefulWidget {
  const AcupointDetailsDialog({super.key, this.bodyPart, this.acupoint});

  final String? bodyPart;
  final Acupoint? acupoint;

  @override
  State<AcupointDetailsDialog> createState() => _AcupointDetailsDialogState();
}

class _AcupointDetailsDialogState extends State<AcupointDetailsDialog> {
  late int _selectedSkinReactionIndex; // To track selected skin reaction
  late int _selectedBloodQuantityIndex; // To track selected blood quantity

  final controller = Get.find<AcupointController>();

  @override
  void initState() {
    super.initState();
    _selectedSkinReactionIndex = widget.acupoint?.skinRection ?? -1;
    _selectedBloodQuantityIndex = widget.acupoint?.bloodQuantity ?? -1;
  }

  Future<void> _simpan() async {
    if (_selectedSkinReactionIndex != -1 && _selectedBloodQuantityIndex != -1) {
      // Close any existing snackbars
      Get.closeAllSnackbars();

      // Add a small delay before showing the new snackbar
      await Future.delayed(const Duration(milliseconds: 100));

      Navigator.pop(context, {
        'skinReaction': _selectedSkinReactionIndex,
        'bloodQuantity': _selectedBloodQuantityIndex,
      });

      // Use duration parameter to ensure snackbar stays visible long enough
      Get.snackbar(
        "Berjaya !",
        "Berjaya tambah acupoint penanda.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
      );
    } else {
      Get.closeAllSnackbars();
      await Future.delayed(const Duration(milliseconds: 100));

      Get.snackbar(
        "Amaran !",
        "Sila pilih kedua-dua tindak balas kulit dan kuantiti darah.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
      );
    }
  }

  Future<void> _kemaskini() async {
    controller.updateAcupoint(
      bodyPart: widget.bodyPart,
      point: widget.acupoint?.point ?? Offset.zero,
      skinReaction: _selectedSkinReactionIndex,
      bloodQuantity: _selectedBloodQuantityIndex,
    );

    Get.back();
  }

  Future<void> _padam() async {
    controller.removeAcupoint(
      bodyPart: widget.bodyPart,
      point: widget.acupoint?.point ?? Offset.zero,
    );
    Get.back();
  }

  void _viewDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero, // Remove default padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            width: Get.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/image/skin_reaction.png', // Replace with your image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                "Tutup",
                style: TextStyle(color: ConstantColor.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: SizedBox(
        width: Get.width * 0.7,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: ConstantColor.primaryColor,
                    ),
                  ),
                ],
              ),
              const Text(
                "Tindak Balas Kulit",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisSpacing: 0, crossAxisSpacing: 0),
                itemCount: 8, // Number of skin reaction options
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSkinReactionIndex = index + 1;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade50,
                            border: _selectedSkinReactionIndex == index + 1
                                ? Border.all(
                                    color: ConstantColor.primaryColor, width: 2)
                                : null,
                          ),
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                                color: _selectedSkinReactionIndex == index + 1
                                    ? ConstantColor.primaryColor
                                    : Colors.grey),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Kuantiti Darah",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(5, (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedBloodQuantityIndex = index + 1;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade50,
                              border: _selectedBloodQuantityIndex == index + 1
                                  ? Border.all(
                                      color: ConstantColor.primaryColor,
                                      width: 2)
                                  : null,
                            ),
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                  color: _selectedBloodQuantityIndex == index + 1
                                      ? ConstantColor.primaryColor
                                      : Colors.grey),
                            )),
                      )
                    ],
                  );
                }),
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () =>
                    widget.acupoint?.point != null ? _kemaskini() : _simpan(),
                title: widget.acupoint?.point != null ? 'Kemaskini' : 'Simpan',
              ),
              if (widget.acupoint?.point != null)
                CustomButton(
                  backgroundColor: Colors.red,
                  onPressed: () => _padam(),
                  title: 'Padam',
                ),
              TextButton(
                onPressed: () => _viewDetails(),
                child: Text(
                  "Lihat butiran",
                  style: TextStyle(
                    color: ConstantColor.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration:
                        TextDecoration.underline, // Add underline to text
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
