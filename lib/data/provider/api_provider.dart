import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class APIProvider extends GetxController {
  final _dio = Dio();

  @override
  void onInit() async {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final data = options.data;
        print(options.path);
        if (data.runtimeType == FormData) {
          print(data.fields);
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
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

    return response;
  }

  Future<Response> get(String url,
      {Map<String, dynamic> formData = const {}}) async {
    final response = await _dio.get(
      url,
      data: FormData.fromMap({...formData}),
    );

    return response;
  }

  Future<Response> put(String url,
      {Map<String, dynamic> formData = const {}}) async {
    final response = await _dio.put(
      url,
      data: FormData.fromMap({...formData}),
    );

    return response;
  }

  Future<Response> delete(String url,
      {Map<String, dynamic> formData = const {}}) async {
    final response = await _dio.delete(
      url,
      data: FormData.fromMap({...formData}),
    );

    return response;
  }
}
