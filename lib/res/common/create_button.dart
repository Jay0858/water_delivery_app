import 'package:flutter/material.dart';
import 'package:water_delivery_app/res/constant/app_colors.dart';

class CreateButton extends StatelessWidget {
  final String? textName;
  final void Function() createOnPress;
  const CreateButton({
    Key? key,
    required this.textName,
    required this.createOnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.DarkBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: createOnPress,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height / 50, horizontal: width / 5),
        child: Text(
          textName ?? "",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.DarkBlack,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
