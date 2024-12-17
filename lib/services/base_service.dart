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
          // Add common headers here
          // options.headers['Authorization'] = 'd979-103-120-175-11';
          // return handler.next(options);
        },
        onResponse: (response, handler) async {
          // Process successful responses here
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          // Process errors here
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
    final Response<dynamic> response =
        await _dio.get('${ApiConstants.baseURL}$url', queryParameters: params);
    return response.data;
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
