import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class CustomDateTimePickerField extends StatefulWidget {
  final String label;
  final Function(String) setter;

  const CustomDateTimePickerField({
    super.key,
    required this.label,
    required this.setter
  });

  @override
  _CustomDateTimePickerFieldState createState() => _CustomDateTimePickerFieldState();
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
      setState(() {
        selectedDate = picked;
        _controller.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              suffixIcon: Icon(Icons.calendar_today, size: 20, color: ConstantColor.primaryColor,),
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

