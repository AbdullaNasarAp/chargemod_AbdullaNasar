import 'package:abdulla_nasar/controller/auth_controller.dart';
import 'package:abdulla_nasar/controller/bottum_nav_controller.dart';
import 'package:abdulla_nasar/controller/splash_controller.dart';
import 'package:abdulla_nasar/controller/user_profile_controller.dart';
import 'package:abdulla_nasar/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SplashController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProfileController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarController(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
