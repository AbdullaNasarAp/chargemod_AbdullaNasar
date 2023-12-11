import 'dart:developer';

import 'package:abdulla_nasar/utils/app_exception.dart';
import 'package:abdulla_nasar/utils/constant.dart';
import 'package:dio/dio.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Interceptorapi {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();

  Future<Dio> getApiUser() async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: 'accessToken');
          dio.interceptors.clear();
          options.headers.addAll({"Authorization": "Bearer $token"});
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          if (e.response != null) {
            if (e.response?.statusCode == 403 &&
                e.response?.data['message'] == 'Forbidden') {
              log('token expired');
              RequestOptions requestOptions = e.requestOptions;
              try {
                final refreshToken = await storage.read(key: 'refreshToken');
                log(refreshToken.toString());
                final opts = Options(method: requestOptions.method);
                dio.options.headers["refresh"] = "Bearer $refreshToken";
                final Response response = await dio.get(
                  Urls.baseUrl + Urls.refreshToken,
                  options: opts,
                );
                if (response.statusCode! == 200) {
                  log(response.data.toString());
                  final token = response.data['accessToken'];
                  final refreshToken = response.data['refreshToken'];
                  await storage.delete(key: 'accessToken');
                  await storage.delete(key: 'refreshToken');
                  storage.write(key: 'accessToken', value: token);
                  storage.write(key: 'refreshToken', value: refreshToken);
                }
              } catch (e) {
                AppExceptions.errorHandler(e);
              }
              try {
                final token = await storage.read(key: 'accessToken');
                final opts = Options(method: requestOptions.method);
                dio.options.headers["Authorization"] = "Bearer $token";
                final response = await dio.request(
                  requestOptions.path,
                  options: opts,
                  cancelToken: requestOptions.cancelToken,
                  onReceiveProgress: requestOptions.onReceiveProgress,
                  data: requestOptions.data,
                  queryParameters: requestOptions.queryParameters,
                );
                return handler.resolve(response);
              } catch (e) {
                AppExceptions.errorHandler(e);
              }
            }
          } else {
            handler.next(e);
          }
        },
      ),
    );
    return dio;
  }
}
