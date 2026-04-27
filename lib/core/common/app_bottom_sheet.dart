import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcare/core/colors/app_colors.dart';
import 'package:medcare/core/common/app_buttons.dart';
import 'package:medcare/core/fonts/app_text.dart';

void showAppBottomSheet({
  required BuildContext context,
  required String title,
  required String subTitle,
  required Widget widget,
  required String buttonTitle,
  required Color buttonColor,
  required void Function() onPressed,
}) {
  showModalBottomSheet(
    isDismissible: true,
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32.r),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 12.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// الخط الصغير فوق
            Center(
              child: Container(
                width: 80.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 28.h),

            Text(
              title,
              style: AppTexts.h3Heading.copyWith(
                color: AppColors.secondry,
              ),
            ),

            SizedBox(height: 11.h),

            Text(
              subTitle,
              style: AppTexts.b3Body.copyWith(
                color: Colors.black54,
              ),
            ),

            widget,

            SizedBox(height: 24.h),

            MainAppButton(
              title: buttonTitle,
              onPressed: onPressed,
              color: buttonColor,
            ),

            SizedBox(height: 20.h),
          ],
        ),
      );
    },
  );
}
