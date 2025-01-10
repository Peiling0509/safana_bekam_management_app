class MedicalHistoryModel {
  String? condition;
  String? medicine;

  MedicalHistoryModel({
    this.condition,
    this.medicine,
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