import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
 @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Text("Dashboard screen"),
      ),
    );
  }
}