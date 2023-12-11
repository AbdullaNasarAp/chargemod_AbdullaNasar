import 'package:abdulla_nasar/controller/splash_controller.dart';
import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashController =
        Provider.of<SplashController>(context, listen: false);
    splashController.checkLogin(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 10, child: SvgPicture.asset("assets/images/logo.svg")),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: LinearProgressIndicator(
                minHeight: 6,
                value: 0.50,
                valueColor: AlwaysStoppedAnimation<Color>(
                  HexColor("E6740C"),
                ),
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
            kHeight(15),
            text(giveText: "Connecting to chargeMOD", fontsize: 10)
          ],
        )),
      ),
    );
  }
}
