import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcare/core/colors/app_colors.dart';
import 'package:medcare/core/common/app_buttons.dart';
import 'package:medcare/core/fonts/app_text.dart';

class VerificationSuccessPage extends StatelessWidget {
  const VerificationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 194.h,
                        width: 245.w,
                        child: Image.asset('assets/images/sucsess.png'),
                      ),
                      SizedBox(height: 45.h),
                      Text(
                        'Verification Successful!',
                        style: AppTexts.h2Heading.copyWith(
                          color: AppColors.secondry,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Your email has been verified. Welcome to Medcare',
                        style: AppTexts.b1Body.copyWith(
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              MainAppButton(
                title: 'Coutinue Your Home',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
