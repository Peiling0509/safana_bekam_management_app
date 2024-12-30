import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AcupointModel {
  String? bodyPart;
  List<Acupoint>? acupoint;

  AcupointModel({this.bodyPart, this.acupoint});
}

class Acupoint {
  Offset? point;
  int? skinRection;
  int? bloodQuantity;

  Acupoint(
      {required this.point,
      required this.skinRection,
      required this.bloodQuantity});
}
