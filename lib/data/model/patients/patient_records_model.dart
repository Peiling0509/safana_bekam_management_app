class PatientRecordModel {
  String? patientId;
  List<PatientRecord>? records;
  String? status;

  PatientRecordModel({
    this.patientId,
    this.records,
    this.status,
  });

  factory PatientRecordModel.fromJson(Map<String, dynamic> json) {
    return PatientRecordModel(
      patientId: json['patient_id']?.toString(),
      records: json['records'] != null
          ? (json['records'] as List)
              .map<PatientRecord>(
                  (x) => PatientRecord.fromJson(x as Map<String, dynamic>))
              .toList()
          : null,
      status: json['status']?.toString(),
    );
  }
}

class PatientRecord {
  final String package;
  final String createdDate;
  final int frequency;
  final int recordId;

  PatientRecord({
    required this.package,
    required this.createdDate,
    required this.frequency,
    required this.recordId,
  });

  factory PatientRecord.fromJson(Map<String, dynamic> json) {
    return PatientRecord(
      package: json['Package'] as String,
      createdDate: json['created_date'] as String,
      frequency: json['frequency'] as int,
      recordId: json['record_id'] as int,
    );
  }
}
