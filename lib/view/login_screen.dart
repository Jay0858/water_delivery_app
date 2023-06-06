import 'package:flutter/material.dart';
import 'package:water_delivery_app/res/common/account_button.dart';
import 'package:water_delivery_app/res/common/text_form_field.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';
import 'package:water_delivery_app/res/constant/app_string.dart';
import 'package:water_delivery_app/view/home_screen.dart';
import 'package:water_delivery_app/view/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool password = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: AppColors.LightBlue, onPressed: () {}),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 20),
          child: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.WelcomeBack,
                  style: TextStyle(
                    color: AppColors.LightBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  AppString.PleaseFill,
                  style: TextStyle(
                    color: AppColors.DarkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: height / 20),
                Text(
                  AppString.Email,
                  style: TextStyle(
                    color: AppColors.DarkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppTextFormField(
                  validator: (value) => value!.isValidEmail() ? null : "Please Enter Correct E-mail",
                  hintText: AppString.EnterEmail,
                  controllers: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: height / 40),
                Text(
                  AppString.Password,
                  style: TextStyle(
                    color: AppColors.DarkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppTextFormField(
                  validator: (value) => value!.isValidPassword() ? null : "Please Enter Correct Password",
                  hintText: AppString.Password,
                  obsuceText: password,
                  controllers: passwordController,
                  keyboardType: TextInputType.text,
                  sufixIcon: IconButton(
                    icon: Icon(color: AppColors.DarkBlack, password ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(
                        () {
                          password = !password;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: height / 70),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppString.ForgotPassword,
                    style: TextStyle(
                      color: AppColors.DarkGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: height / 7),
                SizedBox(
                  width: double.infinity,
                  height: height / 13,
                  child: AccountButton(
                    textName: AppString.Login,
                    accountOnPress: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.DontHaveanAccount,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.DarkGrey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        AppString.SignUP,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.LightBlue,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
