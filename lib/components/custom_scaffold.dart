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
      extendBody: true,
      body: SafeArea(
        //bottom: false,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/image/background_app.png', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            // Screen Content
            body,
          ],
        ),
      )
    );
  }
}
