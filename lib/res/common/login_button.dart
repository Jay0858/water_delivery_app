import 'package:flutter/material.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';

class LoginButton extends StatelessWidget {
  final String? textName;
  final void Function() createOnPress;
  const LoginButton({
    Key? key,
    required this.textName,
    required this.createOnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width / 2.9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          width: 1,
          color: AppColors.white,
          style: BorderStyle.solid,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: createOnPress,
        child: Text(
          textName ?? "",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
