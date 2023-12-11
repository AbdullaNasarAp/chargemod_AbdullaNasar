import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text(giveText: 'User Profile Page'),
      ),
      body: Center(
        child: text(giveText: 'User Profile Adding Page'),
      ),
    );
  }
}
