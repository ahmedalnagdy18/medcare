import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcare/core/colors/app_colors.dart';
import 'package:medcare/core/common/app_bottom_sheet.dart';
import 'package:medcare/core/common/app_buttons.dart';
import 'package:medcare/core/common/app_textfield.dart';
import 'package:medcare/core/extentions/app_extention.dart';
import 'package:medcare/core/fonts/app_text.dart';
import 'package:medcare/features/authentication/presentation/screens/login_page.dart';
import 'package:medcare/features/authentication/presentation/screens/verification_success_page.dart';
import 'package:medcare/features/authentication/presentation/widgets/field_controller_widget.dart';
import 'package:medcare/features/authentication/presentation/widgets/otp_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isObscure = true;
  bool isObscure2 = true;
  final GlobalKey<FormState> _key = GlobalKey();
  bool firstSeen = true;
  bool isButtonEnabled = false;

  final _fullName = FieldControl();
  final _email = FieldControl();
  final _password = FieldControl();
  final _confirmPassword = FieldControl();

  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    _fullName.controller.addListener(_updateButtonState);
    _email.controller.addListener(_updateButtonState);
    _password.controller.addListener(_updateButtonState);
    _confirmPassword.controller.addListener(_updateButtonState);
    super.initState();
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled =
          _fullName.controller.text.isNotEmpty &&
          _email.controller.text.isNotEmpty &&
          _password.controller.text.isNotEmpty &&
          _confirmPassword.controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Have an account? ',
                style: AppTexts.h5Heading.copyWith(
                  color: AppColors.secondry,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Text(
                  'Sign In',
                  style: AppTexts.h5Heading.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          // also hide keyboard automatic
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Create New Account',
                        style: AppTexts.h2Heading.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: 48.h),
                    Text(
                      'Full Name',
                      style: AppTexts.b2Body,
                    ),
                    SizedBox(height: 8.h),
                    AppTextField(
                      controller: _fullName.controller,
                      autovalidateMode: !firstSeen
                          ? AutovalidateMode.onUserInteraction
                          : null,
                      inputFormatters: [
                        PreventStartingSpaceInputFormatter(),
                      ],
                      validator: (val) => AuthValidators.fullName(context, val),
                      hintText: 'Enter Your Full Name',
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Email',
                      style: AppTexts.b2Body,
                    ),
                    SizedBox(height: 8.h),
                    AppTextField(
                      controller: _email.controller,
                      autovalidateMode: !firstSeen
                          ? AutovalidateMode.onUserInteraction
                          : null,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      validator: (val) => AuthValidators.email(context, val),
                      hintText: 'Enter Your Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Password',
                      style: AppTexts.b2Body,
                    ),
                    SizedBox(height: 8.h),
                    AppTextField(
                      controller: _password.controller,
                      autovalidateMode: !firstSeen
                          ? AutovalidateMode.onUserInteraction
                          : null,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      validator: (val) => AuthValidators.password(context, val),
                      obscureText: isObscure,
                      hintText: 'Enter Your Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey[600],
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        child: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Confirm Password',
                      style: AppTexts.b2Body,
                    ),
                    SizedBox(height: 8.h),
                    AppTextField(
                      controller: _confirmPassword.controller,
                      autovalidateMode: !firstSeen
                          ? AutovalidateMode.onUserInteraction
                          : null,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      validator: (val) => AuthValidators.confirmPassword(
                        context,
                        val,
                        _password.controller.text,
                      ),
                      obscureText: isObscure2,
                      hintText: 'Re-enter Your Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey[600],
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isObscure2 = !isObscure2;
                          });
                        },
                        child: Icon(
                          isObscure2 ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    MainAppButton(
                      title: 'Sign In',
                      onPressed: isButtonEnabled
                          ? () {
                              setState(() {
                                firstSeen = false;
                              });
                              if (_key.currentState!.validate()) {
                                // _loginButton(context);
                                showAppBottomSheet(
                                  context: context,
                                  title: 'Enter 4 Digits Code',
                                  subTitle:
                                      'Enter the 4 digits code that you received on your email.',
                                  buttonTitle: 'Continue',
                                  buttonColor: AppColors.primary,
                                  widget: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 85.h),
                                      OtpWidget(controller: otpController),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    otpController.clear();
                                    Navigator.of(context).pushAndRemoveUntil(
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const VerificationSuccessPage(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                );
                              }
                            }
                          : null,
                      color: !isButtonEnabled ? Colors.grey : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
