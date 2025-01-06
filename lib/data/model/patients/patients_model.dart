class PatientsModel {
  int? id;
  String? name;
  String? myKad;
  String? gender;
  String? ethnicity;
  String? mobileNo;
  String? email;
  String? postcode;
  String? state;
  String? address;
  String? occupation;
  List<MedicalHistoryModel> medicalHistory;

  PatientsModel({
    this.id,
    this.name,
    this.myKad,
    this.gender,
    this.ethnicity,
    this.mobileNo,
    this.email,
    this.postcode,
    this.state,
    this.address,
    this.occupation,
    required this.medicalHistory
  });

  factory PatientsModel.fromJson(Map<String, dynamic> json) {
    return PatientsModel(
      id: json['id'],
      name: json['name'] ?? "",
      myKad: json['myKad'] ?? "",
      gender: json['gender'] ?? "",
      ethnicity: json['ethnicity'] ?? "",
      mobileNo: json['p_mobile_no'] ?? "",
      email: json['p_email'] ?? "",
      postcode: json['postcode'] ?? "",
      state: json['state'] ?? "",
      address: json['address'] ?? "",
      occupation: json['occupation'] ?? "",
      medicalHistory: (json['medical_history'] as List<dynamic>?)
              ?.map((e) => MedicalHistoryModel.fromJson(e))
              .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "myKad": myKad,
      "gender": gender,
      "ethnicity": ethnicity,
      "p_mobile_no": mobileNo,
      "p_email": email,
      "postcode": postcode,
      "state": state,
      "address": address,
      "occupation": occupation,
      "medical_history": medicalHistory.map((e) => e.toJson()).toList(),
    };
  }
}

class MedicalHistoryModel {
  String condition;
  String medicine;

  MedicalHistoryModel({
    required this.condition,
    required this.medicine,
  });

  factory MedicalHistoryModel.fromJson(Map<String, dynamic> json) {
    return MedicalHistoryModel(
      condition: json['condition'] ?? "",
      medicine: json['medicine'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "condition": condition,
      "medicine": medicine,
    };
  }
}