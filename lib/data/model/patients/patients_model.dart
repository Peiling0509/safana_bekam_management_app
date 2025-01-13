import 'dart:math' as math;

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
    this.medicalHistory = const [],
  });

  factory PatientsModel.fromJson(Map<String, dynamic> json) {
    // Get the raw lists
    List<String> medicalConditions = List<String>.from(json['medical_history'] ?? []);
    List<String> treatments = List<String>.from(json['treatment_history'] ?? []);
    
    // Create medical history models
    int maxLength = math.max(medicalConditions.length, treatments.length);
    List<MedicalHistoryModel> medicalHistory = [];
    
    for (int i = 0; i < maxLength; i++) {
      medicalHistory.add(MedicalHistoryModel(
        condition: i < medicalConditions.length ? medicalConditions[i] : "",
        medicine: i < treatments.length ? treatments[i] : "",
      ));
    }

    return PatientsModel(
      id: json['id'],
      name: json['name'],
      myKad: json['mykad'],
      gender: json['gender'],
      ethnicity: json['ethnicity'],
      mobileNo: json['p_mobile_no'],
      email: json['p_email'],
      postcode: json['postcode'],
      state: json['state'],
      address: json['address'],
      occupation: json['occupation'],
      medicalHistory: medicalHistory,
    );
  }

  Map<String, dynamic> toJson() {
    // Separate medical conditions and treatments
    List<String> medicalConditions = medicalHistory.map((history) => history.condition ?? "").toList();
    List<String> treatments = medicalHistory.map((history) => history.medicine ?? "").toList();

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