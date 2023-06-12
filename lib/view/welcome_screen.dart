import 'package:flutter/material.dart';
import 'package:water_delivery_app/res/common/create_button.dart';
import 'package:water_delivery_app/res/common/login_button.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';
import 'package:water_delivery_app/res/constant/app_images.dart';
import 'package:water_delivery_app/res/constant/app_string.dart';
import 'package:water_delivery_app/view/login_screen.dart';
import 'package:water_delivery_app/view/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcomepage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height / 1.7),
              Text(
                AppString.WelcometoDripswater,
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: AppString.appFontFamily,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: height / 95),
              Text(
                AppString.Water,
                style: TextStyle(
                  color: AppColors.white,
                  fontFamily: AppString.appFontFamily,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height / 25),
              Padding(
                padding: EdgeInsets.only(left: width / 24, right: width / 24),
                child: CreateButton(
                  textName: AppString.Create,
                  createOnPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ));
                  },
                ),
              ),
              SizedBox(height: height / 45),
              LoginButton(
                textName: AppString.Login,
                createOnPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: height / 50),
              Text(
                AppString.Continue,
                style: TextStyle(
                  color: AppColors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
