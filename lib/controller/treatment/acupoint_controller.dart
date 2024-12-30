import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          bodyFront.value.acupoint?[index].skinRection = skinReaction;
          bodyFront.value.acupoint?[index].bloodQuantity = bloodQuantity;
          bodyFront.refresh();
        }
        break;

      case "Belakang":
        final index = bodyBack.value.acupoint?.indexWhere(
          (acupoint) => acupoint.point == point,
        );
        if (index != null && index != -1) {
          bodyBack.value.acupoint?[index].skinRection = skinReaction;
          bodyBack.value.acupoint?[index].bloodQuantity = bloodQuantity;
          bodyBack.refresh();
        }
        break;

      case "Muka":
        final index = face.value.acupoint?.indexWhere(
          (acupoint) => acupoint.point == point,
        );
        if (index != null && index != -1) {
          face.value.acupoint?[index].skinRection = skinReaction;
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
