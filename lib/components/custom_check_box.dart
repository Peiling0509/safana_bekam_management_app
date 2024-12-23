import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/data/model/shared/checkbox_type.dart';


class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    Key? key,
    this.size = 25,
    this.type = MyCheckboxType.none,
    this.activeBgColor = Colors.lightBlue,
    this.inactiveBgColor = Colors.white,
    this.activeBorderColor = Colors.white,
    this.inactiveBorderColor = Colors.black,
    required this.onChanged,
    required this.value,
    this.activeIcon,
    this.inactiveIcon,
    this.customBgColor = Colors.lightGreenAccent,
    this.autofocus = false,
    this.focusNode, this.checkColor = Colors.white
  }) : super(key: key);
 
  final MyCheckboxType type;
  final double size;
  final Color activeBgColor;
  final Color inactiveBgColor;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final ValueChanged<bool>? onChanged;
  final bool value;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final Color customBgColor;
  final bool autofocus;
  final FocusNode? focusNode;
  final Color? checkColor;
 
  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}
 
class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool get isEnabled => widget.onChanged != null;
 
  @override
  Widget build(BuildContext context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FocusableActionDetector(
              focusNode: widget.focusNode,
              autofocus: widget.autofocus,
              enabled: isEnabled,
              child: InkResponse(
                highlightShape: widget.type == MyCheckboxType.circle
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                containedInkWell: widget.type != MyCheckboxType.circle,
                canRequestFocus: isEnabled,
                onTap: widget.onChanged != null
                    ? () {
                        widget.onChanged!(!widget.value);
                      }
                    : null,
                child: Container(
                  height: widget.size,
                  width: widget.size,
                  margin: widget.type != MyCheckboxType.circle
                      ? const EdgeInsets.all(0)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: isEnabled
                          ? widget.value
                              ? widget.type == MyCheckboxType.custom
                                  ? Colors.white
                                  : widget.activeBgColor
                              : widget.inactiveBgColor
                          : Colors.grey,
                      borderRadius: widget.type == MyCheckboxType.none
                          ? BorderRadius.circular(8)
                          : widget.type == MyCheckboxType.circle
                              ? BorderRadius.circular(50)
                              : BorderRadius.zero,
                      border: Border.all(
                          color: widget.value
                              ? widget.type == MyCheckboxType.custom
                                  ? Colors.black87
                                  : widget.activeBorderColor
                              : widget.inactiveBorderColor)),
                  child: widget.value
                      ? widget.type == MyCheckboxType.custom
                          ? Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  width: widget.size * 0.8,
                                  height: widget.size * 0.8,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: widget.customBgColor),
                                )
                              ],
                            )
                          : widget.activeIcon ??
                              Icon(
                                Icons.check,
                                size: 20,
                                color: widget.checkColor,
                              )
                      : widget.inactiveIcon,
                ),
              ),
            ),
          ]);
}