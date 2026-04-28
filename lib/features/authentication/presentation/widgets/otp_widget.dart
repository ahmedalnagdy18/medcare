import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcare/core/colors/app_colors.dart';
import 'package:medcare/core/fonts/app_text.dart';
import 'package:pinput/pinput.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({
    super.key,
    required this.controller,
    this.onCompleted,
    this.color,
    this.onChanged,
  });
  final TextEditingController? controller;
  final Function(String)? onCompleted;
  final Color? color;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Pinput(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      onCompleted: onCompleted,
      controller: controller,
      preFilledWidget: const Text(
        '',
        style: TextStyle(color: AppColors.red500),
      ),
      errorText: 'Invalid OTP',
      errorTextStyle: const TextStyle(
        color: Colors.red,
      ),
      defaultPinTheme: PinTheme(
        textStyle: AppTexts.h4Heading.copyWith(
          color: AppColors.secondry,
        ),
        height: 40.r,
        width: 70.r,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8).r,
          border: Border.all(
            color: Colors.grey.shade400,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      length: 4,
      focusedPinTheme: PinTheme(
        textStyle: AppTexts.h4Heading.copyWith(
          color: AppColors.secondry,
        ),
        height: 40.r,
        width: 70.r,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8).r,
          border: Border.all(
            color: Colors.grey.shade400,
          ),
        ),
      ),
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
    );
  }
}
