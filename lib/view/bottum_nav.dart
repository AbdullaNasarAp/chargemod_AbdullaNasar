import 'package:abdulla_nasar/controller/bottum_nav_controller.dart';
import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:abdulla_nasar/view/home/home.dart';
import 'package:abdulla_nasar/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottumNavBar extends StatelessWidget {
  const BottumNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<BottomNavigationBarController>(
          builder: (context, bnbController, child) {
            return const [
              HomeScreen(),
              SizedBox(),
              SizedBox(),
              ProfilePage(),
            ][bnbController.currentIndex];
          },
        ),
      ),
      bottomNavigationBar: Consumer<BottomNavigationBarController>(
        builder: (context, bnbController, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                showUnselectedLabels: true,
                unselectedItemColor: HexColor("666766"),
                selectedItemColor: HexColor("E6740C"),
                unselectedLabelStyle: TextStyle(
                  fontSize: 9,
                  color: HexColor("666766"),
                ),
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 10,
                currentIndex: bnbController.currentIndex,
                onTap: (index) {
                  bnbController.updateIndex(index);
                },
                items: [
                  'home',
                  'activity',
                  'community',
                  'profile',
                ].asMap().entries.map((entry) {
                  int index = entry.key;
                  String item = entry.value;

                  String imagePath = 'assets/images/$item.png';

                  return BottomNavigationBarItem(
                    icon: Image.asset(
                      imagePath,
                      color: bnbController.currentIndex == index
                          ? HexColor("E6740C")
                          : HexColor("666766"),
                    ),
                    label: item.capitalize(),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
