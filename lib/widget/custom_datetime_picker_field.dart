import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class CustomDateTimePickerField extends StatefulWidget {
  final String label;
  final String getter;
  final Function(String) setter;

  const CustomDateTimePickerField(
      {super.key,
      required this.label,
      required this.getter,
      required this.setter});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDateTimePickerFieldState createState() =>
      _CustomDateTimePickerFieldState();
}

class _CustomDateTimePickerFieldState extends State<CustomDateTimePickerField> {
  DateTime? selectedDate;
  late final TextEditingController _controller;

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
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    
      widget.setter(_controller.text);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: widget.getter != "" ? widget.getter : "");
    //widget.setter(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.getter.isNotEmpty) {
    //   _controller.text = widget.getter;
    //   widget.setter(widget.getter);
    // }
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
            onChanged: widget.setter,
            controller: _controller,
            readOnly: true,
            onTap: () => _selectDate(context),
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
