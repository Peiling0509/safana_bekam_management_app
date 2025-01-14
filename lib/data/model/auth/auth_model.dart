class AuthModel {
  final String status;
  UserModel? user;

  AuthModel({required this.status, required this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        status: json["id"] ?? "",
        user: json["user"] != null ? UserModel.fromJson(json["user"]) : null);
  }
}

class UserModel {
  int? id;
  String? profilePicture;
  String? username;
  String? email;
  String? mobileNo;
  String? address;
  List<dynamic>? role;

  UserModel(
      {this.id,
      this.profilePicture,
      this.username,
      this.email,
      this.mobileNo,
      this.address,
      this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"] ?? "",
        profilePicture: json["profile_picture"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        mobileNo: json["mobile_no"] ?? "",
        address: json["address"] ?? "",
        role: json["role"] ?? []);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "profile_picture": profilePicture,
      "username": username,
      "email": email,
      "mobile_no": mobileNo,
      "address": address,
      "role": role,
    };
  }
}
