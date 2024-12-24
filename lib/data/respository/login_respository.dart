import 'package:get/get.dart';
import 'package:safana_bekam_management_app/constant/api.dart';
import 'package:safana_bekam_management_app/data/model/auth/auth_model.dart';
import 'package:safana_bekam_management_app/data/model/form/login_form_model.dart';
import 'package:safana_bekam_management_app/data/provider/api_provider.dart';

class LoginRepository {
  final APIProvider provider = Get.find<APIProvider>();

  Future<AuthModel> login(LoginFormModel model) async {
    Map<String, String> formData = {
      'username': model.username,
      'password': model.password
    };
    final res = await provider.post(API.LOGIN, formData: formData);

    if (res.statusCode != 200) throw res;
    if (res.data["status"] != "success") throw res;

    return AuthModel.fromJson(res.data);
  }
}
