import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AcupointModel {
  String? bodyPart;
  List<Acupoint>? acupoint;

  AcupointModel({this.bodyPart, this.acupoint});

  factory AcupointModel.fromJson(Map<String, dynamic> json) {
    return AcupointModel(
      bodyPart: json['body_part'],
      acupoint:
          (json['acupoint'] as List).map((e) => Acupoint.fromJson(e)).toList(),
    );
  }
}

class Acupoint {
  Offset? point;
  int? skinReaction;
  int? bloodQuantity;

  Acupoint({this.point, this.skinReaction, this.bloodQuantity});

  factory Acupoint.fromJson(Map<String, dynamic> json) {
    return Acupoint(
      point: Offset(double.parse(json['coordinate_x'].toString()),
          double.parse(json['coordinate_y'].toString())),
      skinReaction: json['skin_reaction'],
      bloodQuantity: json['blood_quantity'],
    );
  }
}
