import 'package:dio/dio.dart';
import 'package:espace_client/MySharedPrefrences/MySharedPrefrences.dart';
import 'package:espace_client/core/Api/EndPoint.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[ApiKey.idSession] =
        MySharedPrefrences().getData(key: ApiKey.token) != null
            ? '${MySharedPrefrences().getData(key: ApiKey.token)}'
            : null;
    super.onRequest(options, handler);
  }
}
