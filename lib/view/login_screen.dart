import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water_delivery_app/res/common/account_button.dart';
import 'package:water_delivery_app/res/common/text_form_field.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';
import 'package:water_delivery_app/res/constant/app_images.dart';
import 'package:water_delivery_app/res/constant/app_string.dart';
import 'package:water_delivery_app/res/utils/utils.dart';
import 'package:water_delivery_app/view/home_screen.dart';
import 'package:water_delivery_app/view/phone_number_screen.dart';
import 'package:water_delivery_app/view/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // UserModel userModel = UserModel();
  UserCredential? userCredential;
  User? user;
  bool password = false;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Utils utils = Utils();

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
                const Text(
                  AppString.WelcomeBack,
                  style: TextStyle(
                    color: AppColors.LightBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  AppString.PleaseFill,
                  style: TextStyle(
                    color: AppColors.DarkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: height / 20),
                const Text(
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
                const Text(
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
                const Align(
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
                SizedBox(height: height / 20), // LoginButton(textName: AppString.GoogleWithLogin, createOnPress: createOnPress),
                SizedBox(
                  width: double.infinity,
                  height: height / 13,
                  child: AccountButton(
                    textName: AppString.Login,
                    accountOnPress: () {
                      loginUser();
                    },
                  ),
                ),
                SizedBox(height: height / 25),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        color: AppColors.LightGrey,
                        thickness: 1,
                        endIndent: 15,
                      ),
                    ),
                    Text(
                      AppString.OrLoginwith,
                      style: TextStyle(
                        color: AppColors.DarkGrey,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.LightGrey,
                        thickness: 1,
                        indent: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Image.asset(AppImages.Call, height: height / 20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PhoneNumberScreen(),
                          ),
                        );
                      },
                    ),
                    InkWell(
                      child: Image.asset(AppImages.Google, height: height / 20),
                      onTap: () async {
                        debugPrint("userdata =$user");

                        signInWithGoogle();
                        user = userCredential!.user;
                        debugPrint("userdata =$user");

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    InkWell(
                      child: Image.asset(AppImages.Git, height: height / 14),
                      onTap: () async {
                        setState(() {
                          isLoading = false;
                        });
                        try {
                          await signInWithGitHub(context);
                        } on FirebaseAuthException catch (e) {
                          debugPrint(e.message);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: height / 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppString.DontHaveanAccount,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.DarkGrey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        AppString.SignUP,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.LightBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  loginUser() async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        debugPrint("value ----> ${value.user}");
        user = value.user;
        if (user!.emailVerified) {
          utils.showSnackBar(
            context,
            message: "Login Successfully",
          );
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.white,
              elevation: 0,
              content: Text(
                "Please Verify Your Email",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
          debugPrint("Please Verify your Email");
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint("wrong password provided for that user.");
      }
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    debugPrint("googleUser----->$googleUser");

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    user = userCredential!.user;
    debugPrint("User Data ------->>  $user");
    utils.showSnackBar(context, message: "Login Successfully.");
  }

  Future<UserCredential> signInWithGitHub(context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: "99edee821dcb60fef86e",
      clientSecret: "8bf4c272c4c25ae68a0abad45e75ef89b226cfa3",
      redirectUrl: 'https://fir-demo-a7f7b.firebaseapp.com/__/auth/handler',
    );
    final result = await gitHubSignIn.signIn(context);
    final githubAuthCredential = GithubAuthProvider.credential(result.token!);

    return await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
  }
}
