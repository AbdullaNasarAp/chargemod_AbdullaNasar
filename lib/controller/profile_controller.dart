// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:abdulla_nasar/model/get_user_model.dart';
import 'package:abdulla_nasar/utils/constant.dart';
import 'package:abdulla_nasar/utils/interceptor.dart';
import 'package:abdulla_nasar/view/auth/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileController with ChangeNotifier {
  String? firstName;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String? accessToken;
  bool isLoading = false;
  List<String> refreshToken = [];

  Future<User?> fetchData() async {
    isLoading = true;

    final dios = await Interceptorapi().getApiUser();
    const String url = Urls.baseUrl + Urls.getUser;
    accessToken = await secureStorage.read(
      key: 'accessToken',
    );

    try {
      final Response response = await dios.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        dynamic userData = response.data['data']['user'][0];
        User user = User.fromJson(userData);
        firstName = user.firstName;
        refreshToken = user.refreshToken;
        print(
            'User ID: ${user.id}, Mobile: ${user.mobile}, First Name: ${user.firstName}');
        notifyListeners();
        return user;
      } else {
        print('Error: ${response.statusCode}, ${response.statusMessage}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    final dios = await Interceptorapi().getApiUser();
    const String logoutUrl = Urls.logout;

    try {
      final Response response = await dios.post(
        logoutUrl,
        data: {
          'refreshToken': refreshToken[0],
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        accessToken = await secureStorage.read(key: 'accessToken');
        log("accessToken: $accessToken");
        await secureStorage.delete(key: 'accessToken');
        log("accessToken: $accessToken");

        print('Logout successful');
        print(response.data);
        Future.delayed(const Duration(microseconds: 200))
            .then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false));
      } else {
        print('Error: ${response.statusCode}, ${response.statusMessage}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
