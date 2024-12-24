import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/asset_path.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class RecordTreatmentScreen extends StatefulWidget {
  const RecordTreatmentScreen({super.key});

  @override
  State<RecordTreatmentScreen> createState() => _RecordTreatmentScreenState();
}

class _RecordTreatmentScreenState extends State<RecordTreatmentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColor.primaryColor,
      appBar: AppBar(
        title: const Text("Rekod Rawatan"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          _buildProfile(),
          _buildRecord(),
          _buildAddButton(),
        ],
      )),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(Get.width, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Colors.white, // Button color
          ),
          onPressed: () {},
          child: Text(
            "Rawatan Baru",
            style: TextStyle(color: ConstantColor.primaryColor, fontSize: 18),
          )),
    );
  }

  Widget _buildRecord() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.builder(
          //padding: const EdgeInsets.all(30.0),
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rawatan ${index + 1}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text("Tarikh: 10-10-2024",
                              style: const TextStyle(color: Colors.blueGrey)),
                          const SizedBox(height: 5),
                          Text("Pakej: March",
                              style: const TextStyle(color: Colors.blueGrey)),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor:
                              ConstantColor.primaryColor, // Button color
                          minimumSize: const Size(80, 50),
                        ),
                        onPressed: () {},
                        child: const Icon(
                          Icons.print, // Use desired icon
                          color: Colors.white, // Icon color
                          size: 24.0, // Icon size
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircleAvatar(
                  backgroundColor: ConstantColor.primaryColor,
                  child: const Icon(Icons.person_2_outlined, color: Colors.white, size:50,),
                  //backgroundImage: NetworkImage(userInfo.profilePicture ?? ""),
                  //foregroundImage: AssetImage(AssetPath.imageNoFound),
                //   onBackgroundImageError: (exception, stackTrace) =>
                //       throw NetworkImageLoadException,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "XXX XXX XXX",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "xxxxxx-xx-xxxx",
                    style: TextStyle(color: Colors.blueGrey),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 1,
          right: 1,
          child: IgnorePointer(
            ignoring: true,
            child: Image.asset(
              height: 100,
              width: 100,
              AssetPath.backgroundCircle,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
