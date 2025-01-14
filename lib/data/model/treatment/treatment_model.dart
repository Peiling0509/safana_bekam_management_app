import 'package:safana_bekam_management_app/data/model/treatment/acupoint_model.dart';


class TreatmentResponseModel {  
  TreatmentModel? data;  
  String? status;  

  TreatmentResponseModel({  
    this.data,  
    this.status,  
  });  

  factory TreatmentResponseModel.fromJson(Map<String, dynamic> json) {  
    return TreatmentResponseModel(  
      data: json['data'] != null ? TreatmentModel.fromJson(json['data']) : null,  
      status: json['status'],  
    );  
  }  
}  

class TreatmentModel {
  String? recordId;
  String? patientId;
  String? therapistId;
  String? frequency;
  String? createdData;
  String? bloodPressureBefore;
  String? bloodPressureAfter;
  String? package;
  String? healthComplications;
  String? comments;
  List<AcupointModel>? remarks;

  TreatmentModel({
    this.recordId,
    this.patientId,
    this.therapistId,
    this.frequency,
    this.createdData,
    this.bloodPressureBefore,
    this.bloodPressureAfter ,
    this.package,
    this.healthComplications ,
    this.comments ,
    this.remarks,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    return TreatmentModel(
      patientId: json['patient_id'].toString(),
      therapistId: json['therapist_id'].toString(),
      frequency: json['frequency'].toString(),
      createdData: json['created_data'],
      bloodPressureBefore: json['blood_pressure_before'],
      bloodPressureAfter: json['blood_pressure_after'],
      package: json['package'],
      healthComplications: json['health_complications'],
      comments: json['comments'],
      remarks: (json['remarks'] as List)
          .map((e) => AcupointModel.fromJson(e))
          .toList(),
    );
  }
}
