import 'package:abdulla_nasar/controller/auth_controller.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthController>(
        builder: (context, value, child) {
          return Center(
            child: InkWell(
              onTap: () {
                // value.logout(context);
              },
              child: text(giveText: "logout"),
            ),
          );
        },
      ),
    );
  }
}
