// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get_storage/get_storage.dart';
import 'package:safana_bekam_management_app/screen/login/login_screen.dart';

class AuthInterceptor extends Interceptor {
  final _box = GetStorage("Auth");

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Check for session expiration conditions
    if (_isSessionExpired(err)) {
      _handleSessionExpiration();
      return handler.reject(err);
    }
    handler.next(err);
  }

  // Detect session expiration
  bool _isSessionExpired(DioException err) {
    // Common session expiration status codes
    final expiredCodes = [401, 403];

    return expiredCodes.contains(err.response?.statusCode) ||
        _hasSessionExpiredMessage(err);
  }

  // Check for specific expiration messages
  bool _hasSessionExpiredMessage(DioException err) {
    final response = err.response?.data;
    final expiredMessages = [
      'Session expired',
      'Token invalid',
      'Unauthorized',
      'Authentication required'
    ];

    // Handle different response types
    if (response is Map) {
      final message = response['message']?.toString().toLowerCase();
      return expiredMessages
          .any((msg) => message?.contains(msg.toLowerCase()) ?? false);
    } else if (response is String) {
      return expiredMessages
          .any((msg) => response.toLowerCase().contains(msg.toLowerCase()));
    }

    return false;
  }

  // Handle session expiration
  Future<void> _handleSessionExpiration() async {
    // Close all existing dialogs
    await _closeAllDialogs();
    try {
      // Show dialog first
      await _showSessionExpiredDialog();

      // Clear authentication data
      await _clearAuthData();

      // Navigate to login screen
      await _navigateToLogin();
    } catch (e) {
      print('Session Expiration Handling Error: $e');
      // Fallback navigation if something goes wrong
      await _navigateToLogin();
    }
  }

  // Clear stored authentication data
  Future<void> _clearAuthData() async {
    // Clear GetStorage
    await _box.erase();
  }

  // Show dialog to inform user about session expiration
  Future<void> _showSessionExpiredDialog() async {
    final completer = Completer<void>();
    getx.Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Session Expired'),
          content: const Text('Your session has ended. Please log in again.'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                getx.Get.back();
                completer.complete();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
      // Ensure dialog is shown on top of everything
      useSafeArea: true,
    );

    // Wait for dialog to be closed
    return completer.future;
  }

  Future<void> _navigateToLogin() async {
    // Ensure we're not already on login screen
    if (getx.Get.currentRoute == '/login') return;
    // Reset navigation and go to login
    getx.Get.offAll(
      () => const LoginScreen(),
      transition: getx.Transition.fadeIn,
    );
  }

  // Close all existing dialogs
  Future<void> _closeAllDialogs() async {
    // Check if any dialogs are open
    if (getx.Get.isDialogOpen ?? false) {
      // Close all open dialogs
      while (getx.Get.isDialogOpen ?? false) {
        getx.Get.back();
      }
      // Additional safety delay
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }
}

class APIProvider extends getx.GetxController {
  late Dio _dio;
  final box = GetStorage("Auth");

  // Constructor with Dio initialization
  APIProvider() {
    _dio = Dio();
    _initializeInterceptors();
  }

  // Initialize interceptors
  void _initializeInterceptors() {
    _dio.interceptors.clear(); // Clear any existing interceptors

    // Add Auth Interceptor
    _dio.interceptors.add(AuthInterceptor());

    // Add Cookie Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequestInterceptor,
        onResponse: _onResponseInterceptor,
        onError: _onErrorInterceptor,
      ),
    );
  }

  // Request Interceptor
  void _onRequestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) {
    final cookies = cookieKey();
    _logRequestDetails(options);

    if (cookies != null) {
      options.headers['Cookie'] = cookies;
      print("✅ Attached Cookies: $cookies");
    }

    handler.next(options);
  }

  // Response Interceptor
  void _onResponseInterceptor(
      Response response, ResponseInterceptorHandler handler) {
    final cookies = response.headers['set-cookie'];
    if (cookies != null && cookies.isNotEmpty) {
      setCookies(cookies.join('; '));
      //print("🍪 Saved Cookies: ${cookies.join('; ')}");
    }

    handler.next(response);
  }

  // Error Interceptor
  void _onErrorInterceptor(DioException e, ErrorInterceptorHandler handler) {
    print('❌ API Error: ${e.type}');
    print('Error Response: ${e.response?.data}');
    handler.next(e);
  }

  // Log request details
  void _logRequestDetails(RequestOptions options) {
    print('📡 Request Path: ${options.path}');

    if (options.data is FormData) {
      print("📋 Form Data: ${(options.data as FormData).fields}");
    } else if (options.data is Map) {
      print("🗂️ JSON Data: ${options.data}");
    }
  }

  // Cookie management
  String? cookieKey() => box.read("cookies");

  Future<void> setCookies(String? cookies) async {
    if (cookies != null) {
      await box.write("cookies", cookies);
    }
  }

  // Json Method Implementations
  Future<Response> jsonPost(
    String url, {
    Map<String, dynamic> body = const {},
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
       print("✅ JSON POST Response: ${response.data}");
      return response;
    } on DioException catch (e) {
      print('JSON POST Error: ${e.message}');
      rethrow;
    }
  }


  // FormData Method Implementations
  Future<Response> post(
    String url, {
    Map<String, dynamic> formData = const {},
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: FormData.fromMap({...formData}),
      );
      print("✅ POST Response: ${response.data}");
      return response;
    } on DioException catch (e) {
      print('POST Error: ${e.message}');
      rethrow;
    }
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic> queryParameters = const {},
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );
      print("✅ GET Response: ${response.data}");
      return response;
    } on DioException catch (e) {
      print('GET Error: ${e.message}');
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    Map<String, dynamic> formData = const {},
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: FormData.fromMap({...formData}),
      );
      print("✅ PUT Response: ${response.data}");
      return response;
    } on DioException catch (e) {
      print('PUT Error: ${e.message}');
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    Map<String, dynamic> formData = const {},
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: FormData.fromMap({...formData}),
      );
      print("✅ DELETE Response: ${response.data}");
      return response;
    } on DioException catch (e) {
      print('DELETE Error: ${e.message}');
      rethrow;
    }
  }
}
