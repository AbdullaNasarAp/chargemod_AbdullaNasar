import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:abdulla_nasar/controller/auth_controller.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';

class OtpPage extends StatelessWidget {
  final String phoneNumber;

  const OtpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: text(
            giveText: 'Verification',
            fontsize: 16,
            textColor: theme.textTheme.bodyLarge!.color!),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Consumer<AuthController>(
          builder: (context, authProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      kHeight(50),
                      text(
                          giveText:
                              'We’ve send you the verification \n     code on +91 $phoneNumber',
                          textColor: theme.textTheme.bodyLarge!.color!),
                      kHeight(16),
                      Center(
                        child: Pinput(
                          focusNode: FocusNode(),
                          controller: authProvider.otpController,
                          enabled: true,
                          defaultPinTheme: PinTheme(
                              textStyle: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                              decoration: pinPutDecoration(context),
                              height: 60,
                              width: 60),
                          submittedPinTheme: PinTheme(
                            decoration: pinPutDecoration(context),
                            height: 60,
                            width: 60,
                            textStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          followingPinTheme: PinTheme(
                            decoration: pinPutDecoration(context),
                            height: 60,
                            width: 60,
                            textStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          closeKeyboardWhenCompleted: true,
                          length: 4,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                      kHeight(16),
                      kHeight(16),
                      authProvider.timerSeconds > 0
                          ? RichText(
                              text: TextSpan(
                                text: 'Re-send code in ',
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: theme.textTheme.bodyLarge!.color!),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '0.${authProvider.timerSeconds}',
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: HexColor("E6740C")),
                                  ),
                                ],
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                authProvider.resendOtp();
                              },
                              child: text(
                                giveText: "Resend OTP",
                                textColor: HexColor("E6740C"),
                              ),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: RawMaterialButton(
                    onPressed: () async {
                      await authProvider.verifyOtp(phoneNumber, context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 43,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor("E6740C")),
                      child: Center(
                        child: text(
                            giveText: "CONTINUE",
                            textColor: Colors.white,
                            fontsize: 16),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  BoxDecoration pinPutDecoration(BuildContext ctx) {
    return BoxDecoration(
      color: Theme.of(ctx).focusColor,
      border: Border.all(width: 2, color: HexColor("E4DFDF")),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
}
