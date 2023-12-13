import 'package:abdulla_nasar/model/onboarding_model.dart';
import 'package:abdulla_nasar/utils/hex_colors.dart';
import 'package:abdulla_nasar/utils/reusable_widget.dart';
import 'package:abdulla_nasar/view/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

final controller = PageController();

class _OnboardingState extends State<Onboarding> {
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
        img: isDarkMode
            ? 'assets/images/onboarding2.png'
            : 'assets/images/location.png',
        subtitle:
            '       Grab The Best In Class\nDigital Experience Crafted For\n                    EV Drivers',
      ),
      PageViewContentModel(
        text1: 'Interaction with Grid',
        text2: 'RealTime',
        text3: 'Monitoring',
        img: 'assets/images/charger.png',
        subtitle:
            '       Intelligent Sensible Devices\n                Ambicharge Series',
      ),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: PageView.builder(
        padEnds: false,
        controller: controller,
        itemCount: pageViewContentList.length,
        itemBuilder: (context, index) {
          final data = pageViewContentList[index];
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/bg.png",
                ),
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
                    child: text(
                        giveText: "SKIP",
                        fontsize: 16,
                        textColor: theme.textTheme.bodySmall!.color!),
                  ),
                  Center(
                    child: Column(
                      children: [
                        text(
                          giveText: data.text1,
                          fontsize: 16,
                          textColor: theme.textTheme.bodyLarge!.color!,
                        ),
                        text(
                            giveText: data.text2,
                            fontsize: 40,
                            textColor: theme.textTheme.bodyLarge!.color!,
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
                  index == 0
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            data.img,
                            fit: BoxFit.cover,
                            color: isDarkMode ? Colors.white : null,
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
                    child: text(
                      giveText: data.subtitle,
                      fontsize: 15,
                      textColor: theme.textTheme.bodyLarge!.color!,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      index != 0 ? kWidth(0) : kWidth(80),
                      index != 0
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
                            activeDotColor: theme.textTheme.bodyLarge!.color!,
                            type: WormType.thin,
                            dotColor: theme.textTheme.bodyLarge!.color!
                                .withOpacity(0.5),
                          ),
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
        },
      ),
    );
  }
}
