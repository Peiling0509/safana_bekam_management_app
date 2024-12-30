import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/components/top_bar.dart';
import 'package:safana_bekam_management_app/screen/patient/add_customer_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopBar(),
            _middlePartTitle(),
            _middlePartSearchBar(),
            _totalCustomer_AddButton(),
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
        'Pelanggan',
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
            borderRadius: BorderRadius.circular(20),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ));
  }

  Widget _totalCustomer_AddButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Jumlah Pelanggan: 200',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle add button click
              print('Add button clicked');
              Get.to(
                  const AddCustomerFormScreen(),
                  //AddCustomerFormScreen(),
                  fullscreenDialog: true,
                  transition: Transition.rightToLeft,
                );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: ConstantColor.primaryColor,
              minimumSize: const Size(80, 40),
              //padding: EdgeInsets.only(top: 5, bottom: 5),
            ),
            child: const Icon(
              Icons.person_add,
              color: Colors.white,
            ),
          ),
        ],
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
