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
  List<dynamic>? medicalHistory;

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
    this.medicalHistory
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
      medicalHistory:json["medical_history"] ?? []
    );
  }
}
