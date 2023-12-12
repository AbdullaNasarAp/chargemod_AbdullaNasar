import 'dart:async';
import 'dart:developer';
import 'package:abdulla_nasar/utils/interceptor.dart';
import 'package:abdulla_nasar/view/bottum_nav.dart';
import 'package:abdulla_nasar/view/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashController with ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? signInstate;
  void checkLogin(BuildContext context) async {
    Interceptorapi().getApiUser();
    await Future.delayed(
      const Duration(seconds: 3),
    );
    signInstate = await storage.read(key: 'accessToken');
    log(signInstate.toString());
    if (signInstate != null) {
      Future.delayed(
        const Duration(milliseconds: 200),
      ).then(
        (value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottumNavBar(),
          ),
          (route) => false,
        ),
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 200),
      ).then(
        (value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Onboarding(),
          ),
          (route) => false,
        ),
      );
    }
    notifyListeners();
  }
}
