import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:water_delivery_app/res/common/main_button.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';
import 'package:water_delivery_app/res/constant/app_images.dart';
import 'package:water_delivery_app/res/constant/app_string.dart';
import 'package:water_delivery_app/view/welcome_screen.dart';

class OnboadingScreen extends StatefulWidget {
  const OnboadingScreen({Key? key}) : super(key: key);

  @override
  State<OnboadingScreen> createState() => _OnboadingScreenState();
}

class _OnboadingScreenState extends State<OnboadingScreen> {
  int selectedIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  List<Map<String, dynamic>> onBoardingList = [
    {
      "image": AppImages.onboadingone,
      "text": AppString.weProvide,
      "subText": AppString.loremIpsum,
    },
    {
      "image": AppImages.onboadingtwo,
      "text": AppString.weProvide,
      "subText": AppString.loremIpsum,
    },
    {
      "image": AppImages.onboadingone,
      "text": AppString.weProvide,
      "subText": AppString.loremIpsum,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.white,
                  height: height / 1.5,
                  child: PageView(
                      onPageChanged: (value) {
                        selectedIndex = value;
                        setState(() {});
                      },
                      controller: pageController,
                      children: onBoardingList.map((value) {
                        return Column(
                          children: [
                            SizedBox(height: height / 7),
                            Center(
                              child: Image.asset(
                                value["image"],
                                height: height / 2.5,
                              ),
                            ),
                            SizedBox(height: height / 95),
                            Text(
                              value["text"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.DarkGrey,
                                fontFamily: AppString.appFontFamily,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: height / 25),
                            Text(
                              value["subText"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.DarkGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        );
                      }).toList()),
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                    controller: pageController, // PageController
                    count: 3,
                    effect: SwapEffect(
                      activeDotColor: AppColors.LightBlue,
                      dotColor: AppColors.LightWhite,
                      dotHeight: height / 150,
                      dotWidth: width / 20,
                    ),
                    onDotClicked: (index) {}),
              ),
              SizedBox(height: height / 15),
              MainButton(
                textName: selectedIndex == 2 ? AppString.GetStarted : AppString.Next,
                mainOnPress: () {
                  if (selectedIndex == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                    );
                  } else {
                    pageController.nextPage(duration: const Duration(milliseconds: 700), curve: Curves.linear);
                  }
                },
              ),
              SizedBox(height: height / 15),
            ],
          ),
        ],
      ),
    );
  }
}
