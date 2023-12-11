import 'package:abdulla_nasar/controller/auth_controller.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatelessWidget {
  final String phoneNumber;

  const OtpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthController>(
          builder: (context, authProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter OTP sent to $phoneNumber'),
                kHeight(16),
                TextField(
                  controller: authProvider.otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'OTP'),
                ),
                kHeight(16),
                ElevatedButton(
                  onPressed: () async {
                    await authProvider.verifyOtp(phoneNumber, context);
                  },
                  child: Text('Verify OTP'),
                ),
                kHeight(16),
                authProvider.timerSeconds > 0
                    ? Text('Resend OTP in ${authProvider.timerSeconds} seconds')
                    : ElevatedButton(
                        onPressed: () {
                          authProvider.resetTimer();
                        },
                        child: Text('Resend OTP'),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
