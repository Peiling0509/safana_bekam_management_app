import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class APIProvider extends GetxController {
  final _dio = Dio();
  //static const String cookieKey = 'cookies';

  final box = GetStorage("Auth");
  String? cookieKey() => box.read("cookies");

  Future<void> setCookies(String? cookies) async {
    if (cookies != null) {
      await box.write("cookies", cookies);
    }
  }

  @override
  void onInit() async {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final data = options.data;
        final cookies = cookieKey();

        print(options.path);
        if (data.runtimeType == FormData) {
          print("FORM DATA: ${data.fields}");
        }

        if (cookies != null) {
          options.headers['Cookie'] = cookies;
          print("Attached Cookies: $cookies");
        }

        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // Save cookies if present in the response headers
        final cookies = response.headers['set-cookie'];
        if (cookies != null && cookies.isNotEmpty) {
          await setCookies(cookies.join('; '));
          print("Saved Cookies: ${cookies.join('; ')}");
        }
        return handler.next(response);
      },
      onError: (e, handler) {
        print(e.response?.data);
        return handler.next(e);
      },
    ));

    super.onInit();
  }

  Future<Response> post(String url,
      {Map<String, dynamic> formData = const {}}) async {
    final response = await _dio.post(
      url,
      data: FormData.fromMap({...formData}),
    );
    print("POST: ${response.data}");
    return response;
  }

  Future<Response> get(String url,
      {Map<String, dynamic> formData = const {}}) async {
    final response = await _dio.get(
      url,
      data: FormData.fromMap({...formData}),
    );
    print("GET: ${response.data}");

    return response;
  }

  Future<Response> put(String url,
      {Map<String, dynamic> formData = const {}}) async {
    final response = await _dio.put(
      url,
      data: FormData.fromMap({...formData}),
    );
    print("PUT: ${response.data}");
    return response;
  }

  Future<Response> delete(String url,
      {Map<String, dynamic> formData = const {}}) async {
    final response = await _dio.delete(
      url,
      data: FormData.fromMap({...formData}),
    );
    print("DELETE: ${response.data}");
    return response;
  }
}
