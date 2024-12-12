import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
import 'package:safana_bekam_management_app/components/top_bar.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class SearchPatientScreen extends StatefulWidget {
  const SearchPatientScreen({super.key});

  @override
  State<SearchPatientScreen> createState() => _SearchPatientScreenState();
}

class _SearchPatientScreenState extends State<SearchPatientScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(
              userName: "Ali",
              lastLoginTime: "XX-XX-XXXX 00:00:00",
              onNotificationTap: () {
                print("Notification clicked");
              },
              onLogoutTap: () {
                print("Logout clicked");
              },
            ),
            _middlePartTitle(),
            _middlePartSearchBar(),
            _middlePartMinorTitle(),
            Expanded(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 10),
                  child: _customerList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _middlePartTitle() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Rekod Rawatan',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _middlePartSearchBar() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Light shadow
                blurRadius: 10, // Softness of the shadow
                offset: const Offset(0, 4), // Position of the shadow
              ),
            ],
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Carikan",
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.3),
              ),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ));
  }

  Widget _middlePartMinorTitle() {
    return const Padding(
      padding: EdgeInsets.all(18.0),
      child: Text(
        'Rekod Pelanggan Terkini :',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _customerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: 13,
          itemBuilder: (context, index) {
            final name = index == 12 ? 'Last' : 'Customer $index';
            return GestureDetector(
              onTap: () {
                // Handle customer tile click
                print('Customer $name clicked');
              },
              child: _buildCustomerTile(name),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCustomerTile(String name) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: ConstantColor.primaryColor,
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title: Text(name),
        subtitle: const Text('XXXXXX-XX-XXXX'),
      ),
    );
  }
}
