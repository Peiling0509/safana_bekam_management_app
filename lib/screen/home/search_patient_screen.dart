import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';

class SearchPatientScreen extends StatefulWidget {
  const SearchPatientScreen({super.key});

  @override
  State<SearchPatientScreen> createState() => _SearchPatientScreenState();
}

class _SearchPatientScreenState extends State<SearchPatientScreen> {
  @override
  Widget build(BuildContext context) {
     return CustomScaffold(
      body: Center(child: Text("Search screen"),),
    );
  }
}