import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/api.dart';
import 'package:safana_bekam_management_app/data/model/auth/auth_model.dart';
import 'package:safana_bekam_management_app/data/provider/api_provider.dart';

class UserRepository {
  final APIProvider provider = Get.find<APIProvider>();

  Future<dynamic> updateUser(UserModel model) async {
    Map<String, String> formData = {
      'user_id': model.id.toString(),
      'email': model.email ?? "",
      'username':model.username ?? "",
      'mobile_no':model.mobileNo ?? "",
      'address' : model.address ?? ""
    };

    final res = await provider.post(API.UPDATE_USER, formData: formData);

    if (res.statusCode != 200) throw res;
    if (res.data["status"] != "success") throw res;

    return res;
  }
}