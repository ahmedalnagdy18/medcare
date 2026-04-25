import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcare/core/colors/app_colors.dart';
import 'package:medcare/core/fonts/app_text.dart';

class MainAppButton extends StatelessWidget {
  const MainAppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.icon,
  });
  final String title;
  final void Function()? onPressed;
  final Color? color;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(2),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8.r),
          ),
        ),
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, 37.h)),
        padding: WidgetStatePropertyAll(
          EdgeInsetsGeometry.symmetric(vertical: 10.h),
        ),
        backgroundColor: WidgetStatePropertyAll(color ?? AppColors.primary),
      ),
      label: Text(
        title,
        style: AppTexts.button,
      ),
      icon: icon,
      onPressed: onPressed,
    );
  }
}
