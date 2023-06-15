import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void showToastMassage({
    String? message,
  }) {
    Fluttertoast.showToast(
      msg: message ?? "",
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.yellow,
    );
  }

  // snack bar

  void showSnackBar(
    BuildContext context, {
    String? message,
    String? label,
    void Function()? onPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        animation: CurvedAnimation(parent: kAlwaysCompleteAnimation, curve: Curves.bounceIn),
        closeIconColor: Colors.white,
        showCloseIcon: true,
        action: SnackBarAction(
          label: label ?? "",
          onPressed: onPressed ?? () {},
        ),
      ),
    );
  }
}
