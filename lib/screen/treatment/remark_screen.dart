import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:safana_bekam_management_app/controller/treatment/acupoint_controller.dart';
import 'package:safana_bekam_management_app/data/model/treatment/acupoint_model.dart';
import 'package:safana_bekam_management_app/widget/acupoint_details_dialog.dart';
import 'package:safana_bekam_management_app/widget/custom_button.dart';

class RemarkScreen extends StatefulWidget {
  const RemarkScreen({super.key});

  @override
  State<RemarkScreen> createState() => _RemarkScreenState();
}

class _RemarkScreenState extends State<RemarkScreen> {
  late PhotoViewController _photoController;
  late PageController _pageController;
  int _currentPageIndex = 0;

  final controller = Get.find<AcupointController>();

  @override
  void initState() {
    super.initState();
    _photoController = PhotoViewController(initialScale: 0.9);
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _photoController.dispose();
    super.dispose();
  }

  void _handleLongPress({
    required GlobalKey photoViewKey,
    required LongPressStartDetails details,
  }) {
    final RenderBox renderBox =
        photoViewKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = _photoController.position;
    final localPosition = renderBox.globalToLocal(details.globalPosition);

    final scale = _photoController.scale ?? 1.0;

    final relativeX = (localPosition.dx - size.width / 2 - position.dx) / scale;
    final relativeY =
        (localPosition.dy - size.height / 2 - position.dy) / scale;

    final markerPosition = Offset(relativeX, relativeY);

    if (relativeX.abs() < size.width && relativeY.abs() < size.height) {
      // Show dialog to input acupoint details
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return const AcupointDetailsDialog();
        },
      ).then((value) {
        if (value != null) {
          // Add the acupoint to the controller
          controller.addAcupoint(
            bodyPart: controller
                .bodyPart[_currentPageIndex], // Use the current body part
            point: markerPosition,
            skinReaction: value['skinReaction'],
            bloodQuantity: value['bloodQuantity'],
          );
        }
      });
    }
  }

  // void _handleLongPress(
  //     {required GlobalKey photoViewKey,
  //     required LongPressStartDetails details,
  //     required List<Offset> markers}) {
  //   final RenderBox renderBox =
  //       photoViewKey.currentContext!.findRenderObject() as RenderBox;
  //   final size = renderBox.size;
  //   final position = _photoController.position;
  //   final localPosition = renderBox.globalToLocal(details.globalPosition);

  //   final scale = _photoController.scale ?? 1.0;

  //   final relativeX = (localPosition.dx - size.width / 2 - position.dx) / scale;
  //   final relativeY =
  //       (localPosition.dy - size.height / 2 - position.dy) / scale;

  //   if (relativeX.abs() < size.width && relativeY.abs() < size.height) {
  //     setState(() {
  //       markers.add(Offset(relativeX, relativeY));
  //     });
  //   }
  // }

  void _handleNextButton(bool toNext) {
    if (toNext) {
      if (_currentPageIndex < 2) {
        _currentPageIndex++;
        _pageController.animateToPage(
          _currentPageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } else {
      if (_currentPageIndex > 0) {
        _currentPageIndex--;
        _pageController.animateToPage(
          _currentPageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Catatan")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.75,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: _currentPageIndex != 0
                                ? () => _handleNextButton(false)
                                : null,
                            icon: Icon(
                              _currentPageIndex != 0
                                  ? Icons.arrow_circle_left_outlined
                                  : null,
                              size: 40,
                            ),
                          ),
                          Expanded(
                            child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPageIndex = index;
                                });
                              },
                              children: [
                                Obx(() => _buildBodyView(
                                    photoViewKey:
                                        controller.bodyFrontPhotoViewKey.value,
                                    imageProvider:
                                        controller.bodyFrontPhoto.value,
                                    acupoints:
                                        controller.getbodyFrontAcupoints)),
                                Obx(() => _buildBodyView(
                                    photoViewKey:
                                        controller.bodyBackPhotoViewKey.value,
                                    imageProvider:
                                        controller.bodyBackPhoto.value,
                                    acupoints:
                                        controller.getbodyBackAcupoints)),
                                Obx(() => _buildBodyView(
                                    photoViewKey:
                                        controller.facePhotoViewKey.value,
                                    imageProvider: controller.facePhoto.value,
                                    acupoints: controller.getfaceAcupoints))
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: _currentPageIndex < 2
                                ? () => _handleNextButton(true)
                                : null,
                            icon: Icon(
                              _currentPageIndex < 2
                                  ? Icons.arrow_circle_right_outlined
                                  : null,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.bodyPart.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentPageIndex == index ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(title: "Simpan", onPressed: null),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyView(
      {required GlobalKey photoViewKey,
      required AssetImage imageProvider,
      required List<Acupoint> acupoints}) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              controller.bodyPart[_currentPageIndex],
              style: const TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            width: Get.width * 0.6,
            height: Get.height * 0.7,
            child: ClipRect(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: () => Get.snackbar(
                      "Amaran !",
                      "Sila tekan lama untuk menambah acupoint penanda",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    ),
                    onLongPressStart: (details) {
                      _handleLongPress(
                          photoViewKey: photoViewKey, details: details);
                    },
                    child: PhotoView(
                      key: photoViewKey,
                      imageProvider: imageProvider,
                      controller: _photoController,
                      backgroundDecoration:
                          const BoxDecoration(color: Colors.white),
                      minScale: PhotoViewComputedScale.contained * 1,
                      maxScale: PhotoViewComputedScale.covered * 2,
                      basePosition: Alignment.center,
                    ),
                  ),
                  StreamBuilder<PhotoViewControllerValue>(
                    stream: _photoController.outputStateStream,
                    builder: (context, snapshot) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          final scale = _photoController.scale ?? 1.0;
                          final position = _photoController.position;
                          return Stack(
                            children: acupoints.map((acupoint) {
                              final dx = (acupoint.point!.dx * scale) +
                                  position.dx +
                                  constraints.maxWidth / 2;
                              final dy = (acupoint.point!.dy * scale) +
                                  position.dy +
                                  constraints.maxHeight / 2;
                              return Positioned(
                                left: dx - 12.5,
                                top: dy - 12.5,
                                child: GestureDetector(
                                  onTap: () => showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AcupointDetailsDialog(
                                        bodyPart: controller
                                            .bodyPart[_currentPageIndex],
                                        acupoint: acupoint,
                                      );
                                    },
                                  ),
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.red,
                                          spreadRadius: 4,
                                          blurRadius: 5,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
