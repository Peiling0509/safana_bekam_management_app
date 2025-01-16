import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class CustomDateTimePickerField extends StatefulWidget {
  final String label;
  final String getter;
  final Function(String) setter;
  final bool readOnly;

  const CustomDateTimePickerField(
      {super.key,
      required this.label,
      required this.getter,
      required this.setter,
      this.readOnly = false});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDateTimePickerFieldState createState() =>
      _CustomDateTimePickerFieldState();
}

class _CustomDateTimePickerFieldState extends State<CustomDateTimePickerField> {
  DateTime? selectedDate;
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      _controller.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      widget.setter(_controller.text);
    }
  }

  String convertDateFormat(String inputDate) {
    try {
      // Parse the input date in DD/MM/YYYY format
      final DateTime parsed = DateFormat('dd/MM/yyyy').parse(inputDate);
      // Format it to YYYY-MM-DD
      return DateFormat('yyyy-MM-dd').format(parsed);
    } catch (e) {
      print('Error converting date format: $e');
      return inputDate;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.getter.isNotEmpty) {
      // Convert the date format if it's in DD/MM/YYYY format
      _controller.text = convertDateFormat(widget.getter);
      widget.setter(_controller.text);
      try {
        selectedDate = DateTime.parse(_controller.text);
      } catch (e) {
        print('Error parsing initial date: $e');
      }
    } else {
      print("Date was empty");
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            //onChanged:(value) => widget.getter,
            controller: _controller,
            readOnly: true,
            onTap: () {
              if (!widget.readOnly) {
                _selectDate(context);
              }
            },
            decoration: InputDecoration(
              hintText: '//',
              suffixIcon: Icon(
                Icons.calendar_today,
                size: 20,
                color: ConstantColor.primaryColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ConstantColor.primaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
