import 'package:flutter/material.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/components/top_bar.dart';

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
            TopBar(
              userName: "Ali",
              lastLoginTime: "XX-XX-XXXX 00:00:00",
              onNotificationTap: (){
                print("Notification clicked");
              },
              onLogoutTap: (){
                print("Logout clicked");
              },
            ),

            _middlePartTitle(),
            _middlePartSearchBar(),
            _TotalCustomer_AddButton(),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _TotalCustomer_AddButton() {
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
            },
            child: Icon(
              Icons.person_add,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: ConstantColor.primaryColor,
              minimumSize: const Size(80, 40),
              //padding: EdgeInsets.only(top: 5, bottom: 5),
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
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
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
      margin: EdgeInsets.only(bottom: 20),
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
        subtitle: Text('XXXXXX-XX-XXXX'),
      ),
    );
  }
}
