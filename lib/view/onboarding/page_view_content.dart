import 'package:abdulla_nasar/model/onboarding_model.dart';
import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:abdulla_nasar/view/auth/login.dart';
import 'package:abdulla_nasar/view/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewContent extends StatelessWidget {
  const PageViewContent({
    Key? key,
    required this.data,
    required this.isFirstPage,
  }) : super(key: key);

  final PageViewContentModel data;
  final bool isFirstPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              },
              child: text(giveText: "SKIP", fontsize: 16),
            ),
            Center(
              child: Column(
                children: [
                  text(giveText: data.text1, fontsize: 16),
                  text(
                      giveText: data.text2,
                      fontsize: 40,
                      fontweight: FontWeight.w700),
                  text(
                    giveText: data.text3,
                    fontsize: 40,
                    fontweight: FontWeight.w700,
                    textColor: HexColor("E6740C"),
                  )
                ],
              ),
            ),
            isFirstPage
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      data.img,
                      fit: BoxFit.cover,
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      data.img,
                      height: 262,
                      width: 250,
                    ),
                  ),
            Center(
              child: text(giveText: data.subtitle, fontsize: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !isFirstPage ? kWidth(0) : kWidth(80),
                !isFirstPage
                    ? RawMaterialButton(
                        onPressed: () {
                          controller.previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor("E6740C"),
                              borderRadius: BorderRadius.circular(30)),
                          width: 52,
                          height: 52,
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : kWidth(0),
                kWidth(50),
                Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    effect: WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        strokeWidth: 10,
                        paintStyle: PaintingStyle.fill,
                        activeDotColor: HexColor("2E2E2D"),
                        type: WormType.thin,
                        dotColor: HexColor("666766")),
                    onDotClicked: (index) {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.ease,
                      );
                    },
                    count: 3,
                  ),
                ),
                kWidth(50),
                RawMaterialButton(
                  onPressed: () {
                    controller.page == 2
                        ? Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false)
                        : controller.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor("E6740C"),
                        borderRadius: BorderRadius.circular(30)),
                    width: 52,
                    height: 52,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

List<PageViewContentModel> pageViewContentList = [
  PageViewContentModel(
    text1: 'Charge your EV',
    text2: 'At Your',
    text3: 'Fingertips',
    img: 'assets/images/scooterwithcharger.png',
    subtitle: '       Scan Charge and Go\nEffortless Charging schemas',
  ),
  PageViewContentModel(
    text1: 'Easy EV Navigation',
    text2: 'Travel Route',
    text3: 'For Electrics',
    img: 'assets/images/location.png',
    subtitle:
        '       Grab The Best In Class\nDigital Experience Crafted For\n                    EV Drivers',
  ),
  PageViewContentModel(
    text1: 'interaction with Grid',
    text2: 'RealTime',
    text3: 'Monitoring',
    img: 'assets/images/charger.png',
    subtitle:
        '       Intelligent Sensible Devices\n                Ambicharge Series',
  ),
];
