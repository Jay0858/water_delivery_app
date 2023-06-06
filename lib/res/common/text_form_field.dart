import 'package:flutter/material.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(this);
  }
}

extension MobileValidator on String {
  bool isValidMobile() {
    return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(this);
  }
}

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controllers;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function? onFieldSunmitted;
  final IconButton? sufixIcon;
  final bool? obsuceText;

  const AppTextFormField({
    Key? key,
    this.validator,
    this.controllers,
    this.hintText,
    this.keyboardType,
    this.onFieldSunmitted,
    this.sufixIcon,
    this.obsuceText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsuceText ?? false,
      validator: validator,
      controller: controllers,
      keyboardType: keyboardType,
      cursorColor: AppColors.DarkGrey,
      decoration: InputDecoration(
        suffixIcon: sufixIcon,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.DarkGrey,
          ),
        ),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
