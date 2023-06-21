import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:water_delivery_app/model/user_model.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';
import 'package:water_delivery_app/res/constant/app_images.dart';
import 'package:water_delivery_app/res/constant/app_string.dart';
import 'package:water_delivery_app/res/utils/utils.dart';
import 'package:water_delivery_app/view/login_screen.dart';
import 'package:water_delivery_app/view/registration_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  UserModel userModel = UserModel();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  File? imageFile;
  Utils utils = Utils();

  getUser() {
    CollectionReference users = firebaseFirestore.collection('user');
    users.doc(firebaseAuth.currentUser!.uid).get().then((value) {
      debugPrint("User Added -------- > ${jsonEncode(value.data())} ");
      userModel = userModelFromJson(jsonEncode(value.data()));
    }).catchError((error) {
      debugPrint("Failed to Add User : $error");
    });
  }

  pickImage() async {
    image = await picker.pickImage(source: ImageSource.camera);
    imageFile = File(image!.path);
    storeImage();
    setState(() {});
  }

  storeImage() async {
    try {
      UploadTask uploadTask = firebaseStorage.ref().child("image").child("profile_1.jpg").putFile(imageFile!);

      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            debugPrint("upload is $progress% complete.");
            break;
          case TaskState.paused:
            debugPrint("upload  is paused");
            break;
          case TaskState.success:
            debugPrint("upload was success");
            break;
          case TaskState.canceled:
            debugPrint("upload was canceled");
            break;
          case TaskState.error:
            debugPrint("upload was error");
            break;
        }
      });
    } on FirebaseException catch (e) {
      utils.showSnackBar(context, message: e.message);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.LightBlue,
        elevation: 0,
        actions: [
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
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: AppColors.LightBlue),
              accountName: null,
              accountEmail: null,
              currentAccountPictureSize: Size.square(80),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: ClipOval(
                  child: imageFile != null
                      ? Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/google.png",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: Text("${userModel.name}"),
            ),
            ListTile(
              leading: const Icon(Icons.mail_outline),
              title: Text("${userModel.email}"),
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: Text("${userModel.id}"),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                firebaseAuth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ), //Drawer
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: height / 5.5,
              color: AppColors.LightBlue,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.Welcome,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: height / 30),
                    Container(
                      height: height / 18,
                      width: width / 1.1,
                      decoration: BoxDecoration(
                        color: AppColors.LightBlack,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width / 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppString.SearchSomething,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.search,
                            color: AppColors.white,
                          ),
                          SizedBox(width: width / 50),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 40, vertical: height / 40),
              child: Image.asset(
                AppImages.Bottle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
