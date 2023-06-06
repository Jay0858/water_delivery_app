import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_delivery_app/res/common/account_button.dart';
import 'package:water_delivery_app/res/common/text_form_field.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';
import 'package:water_delivery_app/res/constant/app_string.dart';
import 'package:water_delivery_app/view/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool password = false;

  bool conformrmPassword = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();

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
                  AppString.CreateYourAccount,
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
                SizedBox(height: height / 40),
                Text(
                  AppString.Name,
                  style: TextStyle(
                    color: AppColors.DarkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppTextFormField(
                  hintText: AppString.EnterName,
                  controllers: nameController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: height / 40),
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
                SizedBox(height: height / 40),
                Text(
                  AppString.ConfirmPassword,
                  style: TextStyle(
                    color: AppColors.DarkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppTextFormField(
                  hintText: AppString.ConfirmPassword,
                  obsuceText: conformrmPassword,
                  controllers: conformPasswordController,
                  keyboardType: TextInputType.text,
                  sufixIcon: IconButton(
                    icon: Icon(color: AppColors.DarkBlack, conformrmPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(
                        () {
                          conformrmPassword = !conformrmPassword;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: height / 20),
                SizedBox(
                  width: double.infinity,
                  height: height / 13,
                  child: AccountButton(
                    textName: AppString.Create,
                    accountOnPress: () {
                      if (password == conformrmPassword) {
                        creatUser();
                        debugPrint("User ------->> $user");
                      } else {
                        //"Password is Not Match";
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            content: Text(
                              "Not Match Password...",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.Already,
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
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        AppString.Signin,
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

  creatUser() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        debugPrint("User ------->> $user");

        user = value.user;
        debugPrint("Value --> ${value.user}");
        user!.sendEmailVerification();

        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      } else if (e.code == 'strong-password') {
        debugPrint('The Password provided is fully strong');
      }
    } catch (e) {
      debugPrint("Error --->  $e");
    }
  }
}
