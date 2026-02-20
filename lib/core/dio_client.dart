import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;

  DioClient(String baseUrl, {String? token}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      ),
    );
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await dio.post(path, data: data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      final response = await dio.put(path, data: data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? users,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        queryParameters: queryParameters,
        data: users,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
