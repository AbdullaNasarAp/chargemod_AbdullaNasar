import 'package:abdulla_nasar/controller/auth_controller.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(giveText: 'Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthController>(
          builder: (context, authCtrl, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: authCtrl.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),
                kHeight(16),
                ElevatedButton(
                  onPressed: () async {
                    await authCtrl.login(context);
                  },
                  child: text(giveText: 'Login'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
