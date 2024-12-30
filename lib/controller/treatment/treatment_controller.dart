import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/data/model/treatment/acupoint_model.dart';

class TreatmentController extends GetxController {
  var bodyFrontMarkers = <Offset>[].obs;
  var bodyBackMarkers = <Offset>[].obs;
  var faceMarkers = <Offset>[].obs;

  final RxList<String> bodyPart = ["Depan", "Belakang", "Muka"].obs;

  // Rx<AcupointModel> bodyFront =
  //     AcupointModel(bodyPart: "BodyFront", acupoint: []).obs;
  // Rx<AcupointModel> bodyBack =
  //     AcupointModel(bodyPart: "BodyBack", acupoint: []).obs;
  // Rx<AcupointModel> face = AcupointModel(bodyPart: "face", acupoint: []).obs;

  late Rx<AcupointModel> bodyFront;
  late Rx<AcupointModel> bodyBack;
  late Rx<AcupointModel> face;

  var bodyFrontPhotoViewKey = GlobalKey().obs;
  var bodyBackPhotoViewKey = GlobalKey().obs;
  var facePhotoViewKey = GlobalKey().obs;

  final bodyFrontPhoto =
      const AssetImage('assets/image/body/body_front.png').obs;
  final bodyBackPhoto = const AssetImage('assets/image/body/body_back.png').obs;
  final facePhoto = const AssetImage('assets/image/body/face.png').obs;

  @override
  void onInit() {
    super.onInit();
    bodyFront = AcupointModel(bodyPart: bodyPart[0], acupoint: []).obs;
    bodyBack = AcupointModel(bodyPart: bodyPart[1], acupoint: []).obs;
    face = AcupointModel(bodyPart: bodyPart[2], acupoint: []).obs;
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
          skinRection: skinReaction,
          bloodQuantity: bloodQuantity,
        ));
        bodyFront.refresh();
        break;

      case "Belakang":
        bodyBack.value.acupoint ??= [];
        bodyBack.value.acupoint!.add(Acupoint(
          point: point,
          skinRection: skinReaction,
          bloodQuantity: bloodQuantity,
        ));
        bodyBack.refresh();
        break;

      case "Muka":
        face.value.acupoint ??= [];
        face.value.acupoint!.add(Acupoint(
          point: point,
          skinRection: skinReaction,
          bloodQuantity: bloodQuantity,
        ));
        face.refresh();
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
