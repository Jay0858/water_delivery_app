import 'package:flutter/material.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';

class MainButton extends StatelessWidget {
  final String? textName;
  final void Function() mainOnPress;
  const MainButton({
    Key? key,
    this.textName,
    required this.mainOnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.LightBlue,
        foregroundColor: AppColors.LightWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: mainOnPress,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height / 45, horizontal: width / 3),
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
