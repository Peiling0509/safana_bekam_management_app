import 'dart:ffi';

class PatientMonthlySortedModel {
  List<PatientMonthlySortedDataModel>? data;
  String? status;

  PatientMonthlySortedModel({
    this.data,
    this.status,
  });

  factory PatientMonthlySortedModel.fromJson(Map<String, dynamic> json) {
    return PatientMonthlySortedModel(
      data: json['data'] != null
          ? (json['data'] as List)
              .map<PatientMonthlySortedDataModel>(
                  (x) => PatientMonthlySortedDataModel.fromJson(x as Map<String, dynamic>))
              .toList()
          : null,
      status: json['status']?.toString(),
    );
  }
}

class PatientMonthlySortedDataModel {
  final String month;
  final int newPatientsRegistered;
  final int newTreatmentRecords;

  PatientMonthlySortedDataModel({
    required this.month,
    required this.newPatientsRegistered,
    required this.newTreatmentRecords,
  });

  factory PatientMonthlySortedDataModel.fromJson(Map<String, dynamic> json) {
    return PatientMonthlySortedDataModel(
      month: json['month'] ?? "",
      newPatientsRegistered: json['new_patients_registered'] ?? 0,
      newTreatmentRecords: json['new_treatment_records'] ?? 0,
    );
  }
}
