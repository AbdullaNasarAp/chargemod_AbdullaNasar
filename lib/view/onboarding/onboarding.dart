import 'package:abdulla_nasar/view/onboarding/page_view_content.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: PageView.builder(
        padEnds: false,
        controller: controller,
        itemCount: pageViewContentList.length,
        itemBuilder: (context, index) {
          return PageViewContent(
            data: pageViewContentList[index],
            isFirstPage: index == 0,
          );
        },
      ),
    );
  }
}
