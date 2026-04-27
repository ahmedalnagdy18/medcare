import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcare/core/colors/app_colors.dart';
import 'package:medcare/core/fonts/app_text.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? label;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? errorStyle;
  final int? maxLength;
  final double? raduisSize;
  final String? counterText;
  final FocusNode? focusNode;
  final bool? autofocus;
  final bool? readOnly;
  final Color? hintTextColor;
  final Function(String)? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final double? hintFontSize;
  final Color? fillColor;
  final int? minLines;

  const AppTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.maxLines,
    this.label,
    this.onChanged,
    this.inputFormatters,
    this.errorStyle,
    this.maxLength,
    this.raduisSize,
    this.counterText,
    this.focusNode,
    this.autofocus,
    this.readOnly,
    this.hintTextColor,
    this.onFieldSubmitted,
    this.autovalidateMode,
    this.hintFontSize,
    this.fillColor,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: "*",
      contextMenuBuilder: (context, editableTextState) {
        if (readOnly == true) {
          return const SizedBox.shrink();
        }
        return AdaptiveTextSelectionToolbar.editableText(
          editableTextState: editableTextState,
        );
      },
      autovalidateMode: autovalidateMode,
      cursorColor: AppColors.primary,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: readOnly ?? false,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      style: AppTexts.c1Caption,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      controller: controller,
      validator: validator,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        labelText: label,
        labelStyle: AppTexts.c1Caption.copyWith(
          color: Colors.grey[600],
        ),
        counterText: counterText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduisSize ?? 8.r),
          borderSide: BorderSide(color: Colors.red),
        ),

        errorStyle: errorStyle,
        //  AppTexts.small.copyWith(
        //   color: AppColors.errorColor,
        //   overflow: TextOverflow.visible,
        // ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red600),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduisSize ?? 8.r),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduisSize ?? 8.r),
          borderSide: BorderSide(color: fillColor ?? Colors.grey),
        ),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        filled: true,
        fillColor: fillColor ?? AppColors.white,
        hintStyle: AppTexts.c1Caption.copyWith(
          color: hintTextColor ?? Colors.grey[600],
        ),
        //  TextStyle(
        //   fontSize: hintFontSize ?? 14.sp,
        //   fontWeight: FontWeight.w400,
        //   color: hintTextColor ?? AppColors.green900,
        // ),
      ),
    );
  }
}
