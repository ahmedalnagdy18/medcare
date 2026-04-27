import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcare/core/colors/app_colors.dart';
import 'package:medcare/core/common/app_buttons.dart';
import 'package:medcare/core/fonts/app_text.dart';
import 'package:medcare/features/authentication/presentation/screens/login_page.dart';
import 'package:medcare/features/authentication/presentation/screens/sign_up_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 97.r,
                      height: 97.r,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Text(
                      'MEDCARE',
                      style: AppTexts.h1Heading.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'Home Health Care Services',
                      style: AppTexts.s1SubTitle.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Expert medical care at your fingertips. Professional nursing, lab tests, and therapy at home.',
                      style: AppTexts.b1Body,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60.h),
                    MainAppButton(
                      title: 'Log In',
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                    TranceparentAppButton(
                      title: 'Sign Up',
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
