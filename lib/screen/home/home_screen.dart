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

  Widget _topBar() {
    return Container(
      color: ConstantColor.primaryColor,
      width: double.infinity,
      height: 175,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                // Handle notification icon click
                print('Notification icon clicked');
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 15, right: 15),
                child: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, left: 30),
            child: Text(
              "Hai, Ali",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30),
            child: Text(
              "Log Masuk Terakhir: XX-XX-XXXX 00:00:00",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
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
