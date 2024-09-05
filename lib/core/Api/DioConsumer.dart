import 'package:dio/dio.dart';
import 'package:espace_client/core/Api/ApiConsumer.dart';
import 'package:espace_client/core/Api/ApiInspector.dart';
import 'package:espace_client/core/Api/EndPoint.dart';
import 'package:espace_client/core/Errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? mapHeader,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(
          headers: mapHeader,
        ),
      );
      return response.data;
    } on DioException catch (e) {
      print("---!!!!!!!!---");
      print(e.response?.statusCode);
      print(e.message);
      print(e.type);
      print(e.response?.data);
      print("---!!!!!!!!---");
      handleDioExceptions(e);
      return e.response?.data;
    }
  }

  @override
  Future<dynamic> get(String path,
      {dynamic data,
      bool isFromData = false,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? mapHeader}) async {
    try {
      final response = await dio.get(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(
          headers: mapHeader,
        ),
      );

      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  Future<dynamic> get2(String path,
      {dynamic data,
      bool isFromData = false,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? mapHeader}) async {
    try {
      final response = await dio.get(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(
          headers: mapHeader,
        ),
      );

      return response;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
