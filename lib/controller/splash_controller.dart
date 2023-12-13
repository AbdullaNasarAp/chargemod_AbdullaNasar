import 'dart:async';
import 'dart:developer';
import 'package:abdulla_nasar/view/bottum_nav.dart';
import 'package:abdulla_nasar/view/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashController with ChangeNotifier {
  double progressValue = 0.0;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? signInstate;
  void checkLogin(BuildContext context) async {
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

  void startLoading() {
    const duration = Duration(seconds: 1);
    final interval = duration.inMilliseconds / 100;

    for (var i = 0; i <= 100; i++) {
      Future.delayed(
        Duration(milliseconds: (i * interval).round()),
        () {
          progressValue = i.toDouble();
        },
      );
    }
  }
}
