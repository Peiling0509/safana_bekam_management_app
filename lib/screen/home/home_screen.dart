import 'package:flutter/material.dart';
//import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetPath.backgroundApp),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _topBar(),
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
        ],
      ),
    );
  }

  Widget _topBar() {
    return Container(
      color: Colors.blue[900],
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
              backgroundColor: Colors.blue[900],
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
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[900],
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(name),
        subtitle: Text('XXXXXX-XX-XXXX'),
      ),
    );
  }
}
