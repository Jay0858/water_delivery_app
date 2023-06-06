import 'package:flutter/material.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';

class AccountButton extends StatelessWidget {
  final String? textName;
  final void Function() accountOnPress;
  const AccountButton({
    Key? key,
    required this.textName,
    required this.accountOnPress,
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
      onPressed: accountOnPress,
      child: Text(
        textAlign: TextAlign.center,
        textName ?? "",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
