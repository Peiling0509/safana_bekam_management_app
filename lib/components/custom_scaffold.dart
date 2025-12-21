import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/image/background_app.png',
            fit: BoxFit.cover,
          ),
        ),
        // Screen Content
        SafeArea(child: body),
      ],
    ));
  }
}
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
// MajorPatch
