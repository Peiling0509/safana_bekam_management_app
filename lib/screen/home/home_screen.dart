import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
import 'package:safana_bekam_management_app/constant/color.dart';
import 'package:safana_bekam_management_app/components/top_bar.dart';
import 'package:safana_bekam_management_app/controller/auth/auth_controller.dart';
import 'package:safana_bekam_management_app/controller/patient/patient_controller.dart';
import 'package:safana_bekam_management_app/data/model/shared/loader_state_model.dart';
import 'package:safana_bekam_management_app/data/model/user/user_roles_model.dart';
import 'package:safana_bekam_management_app/screen/patient/add_patient_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  final controller = Get.find<PatientController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadPatients();
    });
  }

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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
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
          Obx(() => Text(
                'Jumlah Pelanggan: ${controller.patients.value.length}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              )),
          if (authController.canPerformAction(action: userAction.addNewPatient))
            ElevatedButton(
              onPressed: () {
                Get.to(
                  const AddPatientFormScreen(),
                  fullscreenDialog: true,
                  transition: Transition.rightToLeft,
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: ConstantColor.primaryColor,
                minimumSize: const Size(80, 40),
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
    return Obx(() {
      switch (controller.state.value) {
        case LoaderState.failure:
        case LoaderState.empty:
          return _emptyWidget();
        case LoaderState.initial:
        case LoaderState.loading:
        case LoaderState.loaded:
          final filteredPatients = controller.patients.value
              .where((patient) =>
                  patient.name
                      ?.toLowerCase()
                      .startsWith(_searchQuery.toLowerCase()) ??
                  false)
              .toList();

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: filteredPatients.length,
            itemBuilder: (context, index) {
              final patient = filteredPatients[index];
              return GestureDetector(
                  onTap: () {},
                  child: Container(
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
                      onTap: () => Get.toNamed("/update_patient",
                          arguments: patient.id.toString()),
                      leading: CircleAvatar(
                        backgroundColor: ConstantColor.primaryColor,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(patient.name ?? "null"),
                      subtitle: Text(patient.mobileNo ?? "null"),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ));
            },
          );
      }
    });
  }

  Widget _emptyWidget() {
    return const Center(
      child: Text(
        "Empty patient records.",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  //This is a simulation of smcm (Add UI for the label)
  // Widget _addLabel() {
  //  return const Center(
  //    child: const Icon(Icons.newPatient)
  //  )
  //}

  //This is a simulation of smcm (Add medical-notes-preview)
  // Widget _addNotePreview{
  //  return const Center( 
  //    child: const Text( 
  //      "This is the most recent medical review", 
  //      style: TextStyle(  
  //        fontSize: 16, 
  //       fontWeight: FontWeight.w400, 
  //      ) 
  //    ) 
  //  ) 
  //} 
  //here
  //is
  //the
  //similar
  //widget
  //or
  //function
  //to 
  //demo
  //the
  //feature
  //change
  //scenario
}
