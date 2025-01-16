import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/controller/treatment/treatment_controller.dart';
import 'package:safana_bekam_management_app/data/model/treatment/acupoint_model.dart';

class AcupointController extends GetxController {
  var bodyFrontMarkers = <Offset>[].obs;
  var bodyBackMarkers = <Offset>[].obs;
  var faceMarkers = <Offset>[].obs;

  final RxList<String> bodyPart = ["Depan", "Belakang", "Muka"].obs;

  late Rx<AcupointModel> bodyFront;
  late Rx<AcupointModel> bodyBack;
  late Rx<AcupointModel> face;

  var bodyFrontPhotoViewKey = GlobalKey().obs;
  var bodyBackPhotoViewKey = GlobalKey().obs;
  var facePhotoViewKey = GlobalKey().obs;

  final treatmentController = Get.find<TreatmentController>();

  @override
  void onInit() {
    super.onInit();
    bodyFront = AcupointModel(bodyPart: bodyPart[0], acupoint: []).obs;
    bodyBack = AcupointModel(bodyPart: bodyPart[1], acupoint: []).obs;
    face = AcupointModel(bodyPart: bodyPart[2], acupoint: []).obs;

    //dummy data
    // bodyFront.value.acupoint = [
    //     Acupoint(
    //       point: Offset(-43.0, -184.9),
    //       skinReaction: 1,
    //       bloodQuantity: 5,
    //     ),
    //     Acupoint(
    //       point:  Offset(40.8, -188.2),
    //       skinReaction: 2,
    //       bloodQuantity: 4,
    //     ),
    //     Acupoint(
    //       point: Offset(-0.2, -90.2),
    //       skinReaction: 2,
    //       bloodQuantity: 4,
    //     ),
    //   ];

    // bodyBack.value.acupoint = [
    //     Acupoint(
    //       point: Offset(-34.4, 1.8),
    //       skinReaction: 1,
    //       bloodQuantity: 5,
    //     ),
    //     Acupoint(
    //       point: Offset(-2.4, -364.9),
    //       skinReaction: 2,
    //       bloodQuantity: 4,
    //     ),
    //     Acupoint(
    //       point:Offset(31.1, 229.7),
    //       skinReaction: 2,
    //       bloodQuantity: 4,
    //     ),
    //   ];

    // face.value.acupoint = [
    //     Acupoint(
    //       point:  Offset(-4.4, -234.7),
    //       skinReaction: 1,
    //       bloodQuantity: 5,
    //     ),
    //     Acupoint(
    //       point:Offset(-85.9, 26.5),
    //       skinReaction: 2,
    //       bloodQuantity: 4,
    //     ),
    //     Acupoint(
    //       point:Offset(99.2, 30.0),
    //       skinReaction: 2,
    //       bloodQuantity: 4,
    //     ),
    //   ];
  }

  loadAccupoints() {
    if (treatmentController.getRemarks.isEmpty) return;
    treatmentController.getRemarks.map((e) {
      switch (e.bodyPart) {
        case "Depan":
          bodyFront.value.acupoint = e.acupoint;
          break;
        case "Belakang":
          bodyBack.value.acupoint = e.acupoint;
          break;
        case "Muka":
          face.value.acupoint = e.acupoint;
          break;
        default:
          throw ArgumentError('Invalid body part: ${e.bodyPart}');
      }
    }).toList();
  }

  void simpan() {
    treatmentController.setRemarks = [
      bodyFront.value,
      bodyBack.value,
      face.value
    ];
    Get.back();
  }

  void addAcupoint({
    required String bodyPart,
    required Offset point,
    required int skinReaction,
    required int bloodQuantity,
  }) {
    switch (bodyPart) {
      case "Depan":
        bodyFront.value.acupoint ??= [];
        bodyFront.value.acupoint!.add(Acupoint(
          point: point,
          skinReaction: skinReaction,
          bloodQuantity: bloodQuantity,
        ));
        bodyFront.refresh();
        break;

      case "Belakang":
        bodyBack.value.acupoint ??= [];
        bodyBack.value.acupoint!.add(Acupoint(
          point: point,
          skinReaction: skinReaction,
          bloodQuantity: bloodQuantity,
        ));
        bodyBack.refresh();
        break;

      case "Muka":
        face.value.acupoint ??= [];
        face.value.acupoint!.add(Acupoint(
          point: point,
          skinReaction: skinReaction,
          bloodQuantity: bloodQuantity,
        ));
        face.refresh();
        break;

      default:
        throw ArgumentError('Invalid body part: $bodyPart');
    }
  }

  void updateAcupoint({
    required String? bodyPart,
    required Offset? point,
    required int? skinReaction,
    required int? bloodQuantity,
  }) {
    switch (bodyPart) {
      case "Depan":
        final index = bodyFront.value.acupoint?.indexWhere(
          (acupoint) => acupoint.point == point,
        );
        if (index != null && index != -1) {
          bodyFront.value.acupoint?[index].skinReaction = skinReaction;
          bodyFront.value.acupoint?[index].bloodQuantity = bloodQuantity;
          bodyFront.refresh();
        }
        break;

      case "Belakang":
        final index = bodyBack.value.acupoint?.indexWhere(
          (acupoint) => acupoint.point == point,
        );
        if (index != null && index != -1) {
          bodyBack.value.acupoint?[index].skinReaction = skinReaction;
          bodyBack.value.acupoint?[index].bloodQuantity = bloodQuantity;
          bodyBack.refresh();
        }
        break;

      case "Muka":
        final index = face.value.acupoint?.indexWhere(
          (acupoint) => acupoint.point == point,
        );
        if (index != null && index != -1) {
          face.value.acupoint?[index].skinReaction = skinReaction;
          face.value.acupoint?[index].bloodQuantity = bloodQuantity;
          face.refresh();
        }
        break;

      default:
        throw ArgumentError('Invalid body part: $bodyPart');
    }
  }

  void removeAcupoint({
    required String? bodyPart,
    required Offset? point,
  }) {
    switch (bodyPart) {
      case "Depan":
        bodyFront.value.acupoint
            ?.removeWhere((acupoint) => acupoint.point == point);
        bodyFront.refresh();
        break;

      case "Belakang":
        bodyBack.value.acupoint
            ?.removeWhere((acupoint) => acupoint.point == point);
        bodyBack.refresh();
        break;

      case "Muka":
        face.value.acupoint?.removeWhere((acupoint) => acupoint.point == point);
        face.refresh();
        break;

      default:
        throw ArgumentError('Invalid body part: $bodyPart');
    }
  }

  get getbodyFrontAcupoints => bodyFront.value.acupoint;
  get getbodyBackAcupoints => bodyBack.value.acupoint;
  get getfaceAcupoints => face.value.acupoint;
}
