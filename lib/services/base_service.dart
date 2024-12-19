import 'dart:io';

import 'package:dio/dio.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/services/api_constant.dart';

class BaseService with CustomToastMixin {
  final Dio _dio;

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  BaseService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseURL,
            connectTimeout: const Duration(milliseconds: 60000),
            receiveTimeout: const Duration(milliseconds: 60000),
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // print("Request [${options.method}] => PATH: ${options.path}");
          // print("Request Headers: ${options.headers}");
          // print("Request Data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          // print("Response [${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          // print("Error [${error.response?.statusCode}] => ${error.message}");
          // print("Error Data: ${error.response?.data}");
          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> get(
      {required String url, Map<String, dynamic>? params}) async {
    if (!await hasNetwork()) {
      showCustomToast("Network is not available");
      return;
    }

    try {
      final response = await _dio.get('${_dio.options.baseUrl}$url',
          queryParameters: params);

      // Periksa status code
      if (response.statusCode == 200) {
        print("Response: ${response.data}");
        return response;
      } else {
        print("Error: Status Code ${response.statusCode}");
        showCustomToast("Error: Status Code ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioException) {
        print("DioException: ${e.response?.statusCode}");
        print("Error Data: ${e.response?.data}");
      } else {
        print("Unexpected Error: $e");
      }
    }
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) async {
    try {
      final response =
          await _dio.post('${ApiConstants.baseURL}$url', data: data);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> patch(String url, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.patch(url, data: data);
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(dynamic error) {
    if (error is DioException) {
      print("DioException: ${error.message}");
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('Connection timeout. Please try again later.');
        case DioExceptionType.receiveTimeout:
          throw Exception('Receive timeout. Please try again later.');
        case DioExceptionType.unknown:
          throw Exception('Error: unknown');
        case DioExceptionType.sendTimeout:
          throw Exception('Send timeout. Please try again later.');
        case DioExceptionType.connectionError:
          throw Exception('Connection Error. Please try again later.');
        case DioExceptionType.cancel:
          throw Exception('Canceled');
        case DioExceptionType.badResponse:
        default:
          throw Exception('Something went wrong. Please try again.');
      }
    } else {
      throw Exception('Unexpected error occurred.');
    }
  }
}
