// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:abdulla_nasar/utils/app_toast.dart';
import 'package:abdulla_nasar/utils/constant.dart';
import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/view/auth/otp.dart';
import 'package:abdulla_nasar/view/auth/user_profile.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController with ChangeNotifier {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Dio dio = Dio();
  String? accessToken;
  String? refreshToken;

  Future<void> login(BuildContext context) async {
    if (phoneNumberController.text.isEmpty) {
      AppToast.showToast("Please enter a phone number", errorColor);

      return;
    }
    if (phoneNumberController.text.length != 10) {
      AppToast.showToast(
          "Please enter a valid 10-digit phone number", errorColor);
      return;
    }

    var url = Uri.parse(Urls.baseUrl + Urls.signInUrl);

    try {
      Response response = await dio.post(
        url.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'mobile': phoneNumberController.text},
      );

      if (response.statusCode == 200) {
        print(response.data);

        resetTimer();
        AppToast.showToast(
            "OTP successfully sent. Please check your mobile for the verification code.",
            kBlack);
        Future.delayed(const Duration(milliseconds: 200)).then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpPage(
                phoneNumber: phoneNumberController.text,
              ),
            ),
          ),
        );
      } else {
        print('Login failed: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error during login: $e');
    }

    notifyListeners();
  }

  Future<void> verifyOtp(String phoneNumber, BuildContext context) async {
    if (otpController.text.trim().isEmpty) {
      AppToast.showToast("Please enter a valid OTP", errorColor);
      return;
    }

    var url = Uri.parse(
      Urls.baseUrl + Urls.verifyOtp,
    );

    var request = http.Request('POST', url);
    request.headers['Content-Type'] = 'application/json';
    request.body =
        '{"mobile": "$phoneNumber", "otp": "${otpController.text.trim()}" }';

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        log(responseBody);

        await secureStorage.write(key: "phoneNumber", value: phoneNumber);

        accessToken = extractAccessToken(responseBody);
        refreshToken = extractRefreshToken(responseBody);
        await secureStorage.write(key: 'accessToken', value: accessToken);

        log("accessToken ::: $accessToken");

        Future.delayed(const Duration(milliseconds: 200)).then(
          (value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfilePage(phoneNumber: phoneNumber),
              ),
              (route) => false),
        );
      } else {
        print('OTP verification failed: ${response.reasonPhrase}');
        AppToast.showToast("Invalid OTP", errorColor);
        return;
      }
    } catch (e) {
      print('Error during OTP verification: $e');
    }

    notifyListeners();
  }

  String? extractAccessToken(String responseBody) {
    try {
      Map<String, dynamic> responseMap = jsonDecode(responseBody);
      return responseMap['data']['accessToken'] as String?;
    } catch (e) {
      print('Error extracting access token: $e');
      return null;
    }
  }

  String? extractRefreshToken(String responseBody) {
    try {
      Map<String, dynamic> responseMap = jsonDecode(responseBody);
      return responseMap['data']['refreshToken'] as String?;
    } catch (e) {
      print('Error extracting refresh token: $e');
      return null;
    }
  }

  String _selectedCountryCode = "+91";

  String get selectedCountryCode => _selectedCountryCode;

  void setSelectedCountryCode(String countryCode) {
    _selectedCountryCode = countryCode;
    notifyListeners();
  }

  // String? phone;

  // void readStorage() async {
  //   phone = await secureStorage.read(key: "phoneNumber");
  //   notifyListeners();
  // }

  Future<void> resendOtp() async {
    Dio dio = Dio();
    var url = Urls.baseUrl + Urls.resend;

    try {
      Response response = await dio.post(
        url,
        // options: Options(
        //   headers: {'Content-Type': 'application/json'},
        // ),
        data: {
          'mobile': phoneNumberController.text,
          'type': 'text',
        },
      );

      if (response.statusCode == 200) {
        print(response.data);
        resetTimer();
        AppToast.showToast(
            "OTP successfully sent. Please check your mobile for the verification code.",
            kBlack);
      } else {
        print('Resend OTP failed: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error during resend OTP: $e');
    }
  }

  Timer? _timer;
  int _timerSeconds = 60;

  int get timerSeconds => _timerSeconds;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        _timerSeconds--;
        notifyListeners();
      } else {
        _timer!.cancel();
      }
    });
  }

  void resetTimer() {
    _timerSeconds = 60;
    startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
