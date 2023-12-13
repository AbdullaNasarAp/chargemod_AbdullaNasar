// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:abdulla_nasar/utils/constant.dart';
import 'package:abdulla_nasar/utils/interceptor.dart';
import 'package:abdulla_nasar/view/auth/login.dart';
import 'package:abdulla_nasar/view/bottum_nav.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProfileController with ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String? phone;

  final Dio dio = Dio();

  void readStorage() async {
    phone = await secureStorage.read(key: "phoneNumber");
    log("phone :::: ${phone.toString()}");
    notifyListeners();
  }

  Future<void> registerUser(BuildContext context, String phoneNumber) async {
    Dio dios = await Interceptorapi().getApiUser();

    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty) {
      log('Please fill in all fields.');
      return;
    }
    const String url = Urls.baseUrl + Urls.registerUser;

    try {
      final response = await dios.post(
        url,
        data: {
          "mobile": phoneNumber,
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "email": emailController.text,
        },
      );

      if (response.statusCode == 200) {
        log(response.data.toString());

        final Map<String, dynamic> responseData = response.data;
        final String firstName = responseData['firstName'];
        await secureStorage.write(key: 'firstName', value: firstName);
        log("firstName :: $firstName");
        Future.delayed(const Duration(milliseconds: 200)).then(
          (value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const BottumNavBar(),
              ),
              (route) => false),
        );
      } else {
        log(response.statusMessage.toString());
      }
    } catch (error) {
      log('Error: $error');
    }
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    final refreshToken1 = await secureStorage.read(key: 'refreshToken');
    log(refreshToken1.toString());
    print(refreshToken1.toString());

    var url = Urls.baseUrl + Urls.logout;

    try {
      Response response = await dio.post(
        url,
        data: {'refreshToken': refreshToken1.toString()},
      );

      if (response.statusCode == 200) {
        print(response.data);

        Future.delayed(const Duration(milliseconds: 200))
            .then((value) => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                )));
      } else {
        print('Logout failed: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error during logout: $e');
    }

    notifyListeners();
  }
}
