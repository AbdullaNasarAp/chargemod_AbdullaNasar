// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:abdulla_nasar/utils/app_exception.dart';
import 'package:abdulla_nasar/utils/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Interceptorapi {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Dio dio = Dio();
  bool isRefreshingToken = false;

  Future<Dio> getApiUser() async {
    log("Interceptorapi");

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: 'accessToken');
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
              log('Interceptorapi token expired');

              if (!isRefreshingToken) {
                isRefreshingToken = true;

                try {
                  final refreshToken = await storage.read(key: 'refreshToken');
                  log("Interceptorapi${refreshToken.toString()}");
                  final opts = Options(method: "GET");
                  dio.options.headers["refresh"] = "Bearer $refreshToken";
                  final Response response = await dio.get(
                    Urls.baseUrl + Urls.refreshToken,
                    options: opts,
                  );

                  if (response.statusCode! == 200) {
                    log("Interceptorapi ${response.data.toString()}");
                    final token = response.data['accessToken'];
                    final refreshToken = response.data['refreshToken'];
                    await storage.write(key: 'accessToken', value: token);
                    await storage.write(
                        key: 'refreshToken', value: refreshToken);
                  }
                } catch (e) {
                  AppExceptions.errorHandler(e);
                } finally {
                  isRefreshingToken = false;
                }
              }

              try {
                final token = await storage.read(key: 'accessToken');
                final opts = Options(method: e.requestOptions.method);
                dio.options.headers["Authorization"] = "Bearer $token";
                final response = await dio.request(
                  e.requestOptions.path,
                  options: opts,
                  cancelToken: e.requestOptions.cancelToken,
                  onReceiveProgress: e.requestOptions.onReceiveProgress,
                  data: e.requestOptions.data,
                  queryParameters: e.requestOptions.queryParameters,
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
