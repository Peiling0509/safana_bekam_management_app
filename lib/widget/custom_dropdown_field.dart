import 'package:flutter/material.dart';

class CustomDropdownField extends StatefulWidget {
  final String label;
  final List<String> items;
  final String initialValue;
  final Function(String) onChanged;
  final bool readOnly;

  const CustomDropdownField(
      {super.key,
      required this.label,
      required this.items,
      required this.onChanged,
      this.initialValue = '--Pilih--',
      this.readOnly = false});

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final LayerLink layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool isDropdownOpen = false;
  String _selected = "--Pilih--";

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _selected = widget.initialValue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CompositedTransformTarget(
        link: layerLink,
        child: InkWell(
          onTap: () {
            if (!widget.readOnly) {
              if (isDropdownOpen) {
                _hideDropdown();
              } else {
                _showDropdown();
              }
            }
          },
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
              Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selected,
                      style: TextStyle(
                        color: _selected == '--Pilih--'
                            ? Colors.grey
                            : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                        isDropdownOpen
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdown() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = Overlay.of(context);
    _overlayEntry = _createOverlayEntry(size);
    overlay.insert(_overlayEntry!);
    isDropdownOpen = true;
  }

  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      isDropdownOpen = false;
    });
  }

  void _handleSelection(String item) {
    _selected = item;
    widget.onChanged(item);
    _hideDropdown();
  }

  OverlayEntry _createOverlayEntry(Size size) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: layerLink.leaderSize?.width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height * 0.85),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 48.0 * 4, // Show maximum 4 items at once
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: widget.items.map((String item) {
                      final isSelected = _selected == item;
                      return InkWell(
                        onTap: () => _handleSelection(item),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          child: Text(
                            item,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : (item == '--Select--'
                                      ? Colors.blueGrey
                                      : Colors.black),
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
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
}
