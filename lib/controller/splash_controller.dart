import 'dart:async';
import 'dart:developer';

import 'package:abdulla_nasar/view/auth/login.dart';
import 'package:abdulla_nasar/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashController with ChangeNotifier {
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
            builder: (context) => const HomeScreen(),
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
            builder: (context) => const LoginPage(),
          ),
          (route) => false,
        ),
      );
    }
    notifyListeners();
  }
}
