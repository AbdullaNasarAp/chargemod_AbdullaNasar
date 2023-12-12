import 'package:abdulla_nasar/utils/interceptor.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:abdulla_nasar/view/home/charging_ports_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Interceptorapi().getApiUser();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            image: AssetImage(
              "assets/images/map.png",
            ),
          ),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 700,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: 170,
                      right: 125,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 100,
                          maxHeight: 100,
                        ),
                        child: Image.asset("assets/images/charge_point.png"),
                      ),
                    ),
                    Positioned(
                      top: 300,
                      right: 200,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 100,
                          maxHeight: 100,
                        ),
                        child: Image.asset("assets/images/charge_point.png"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shrinkWrap: true,
                  itemCount: chargingPorts.length,
                  itemBuilder: (context, index) {
                    return ChargingPortCard(
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return kWidth(30);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
