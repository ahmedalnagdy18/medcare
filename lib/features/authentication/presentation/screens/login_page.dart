import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcare/core/colors/app_colors.dart';
import 'package:medcare/core/common/app_bottom_sheet.dart';
import 'package:medcare/core/common/app_buttons.dart';
import 'package:medcare/core/common/app_textfield.dart';
import 'package:medcare/core/fonts/app_text.dart';
import 'package:medcare/features/authentication/presentation/screens/sign_up_page.dart';
import 'package:medcare/features/authentication/presentation/screens/verification_success_page.dart';
import 'package:medcare/features/authentication/presentation/widgets/field_controller_widget.dart';
import 'package:medcare/features/authentication/presentation/widgets/otp_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;
  bool isObscure2 = true;
  bool isObscure3 = true;
  int selectRole = 0;
  final GlobalKey<FormState> _key = GlobalKey();
  final GlobalKey<FormState> _key2 = GlobalKey();
  final GlobalKey<FormState> _key3 = GlobalKey();
  bool firstSeen = true;
  bool isButtonEnabled = false;

  final _email = FieldControl();
  final _password = FieldControl();
  final _forgetPassword = FieldControl();
  final TextEditingController otpController = TextEditingController();
  final _password2 = FieldControl();
  final _password3 = FieldControl();

  @override
  void initState() {
    _email.controller.addListener(_updateButtonState);
    _password.controller.addListener(_updateButtonState);
    super.initState();
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled =
          _email.controller.text.isNotEmpty &&
          _password.controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _forgetPassword.dispose();
    otpController.dispose();
    _password2.dispose();
    _password3.dispose();
    super.dispose();
  }

  bool get _resetPasswordValid =>
      _password2.controller.text.isNotEmpty &&
      _password3.controller.text.isNotEmpty;

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
                'Don’t have an account? ',
                style: AppTexts.h5Heading.copyWith(
                  color: AppColors.secondry,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                child: Text(
                  'Sign Up',
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
                        'Welcome',
                        style: AppTexts.h2Heading.copyWith(
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                    ),
                    SizedBox(height: 48.h),
                    Text(
                      'Sign In',
                      style: AppTexts.h2Heading.copyWith(
                        color: Color(0xFF1E6061),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Sign in to manage your medical visits and view your test results easily.',
                      style: AppTexts.b1Body.copyWith(
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                    SizedBox(height: 56.h),
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
                    SizedBox(height: 8.h),
                    Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          _forgetPassword.controller.clear();
                          showAppBottomSheet(
                            context: context,
                            title: 'Forgot password',
                            subTitle:
                                'Enter your email for the verification proccesss, we will send 4 digits code to your email.',
                            buttonTitle: 'Continue',
                            buttonColor: AppColors.primary,
                            builder: (setStateSheet, isEnabled) => Form(
                              key: _key2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 85.h),
                                  AppTextField(
                                    controller: _forgetPassword.controller,
                                    onChanged: (_) {
                                      isEnabled.value = _forgetPassword
                                          .controller
                                          .text
                                          .isNotEmpty;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                        RegExp(r'\s'),
                                      ),
                                    ],
                                    validator: (val) =>
                                        AuthValidators.email(context, val),
                                    hintText: 'Enter Your Email',
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              if (_key2.currentState!.validate()) {
                                Navigator.pop(context);
                                otpController.clear();
                                showAppBottomSheet(
                                  context: context,
                                  title: 'Enter 4 Digits Code',
                                  subTitle:
                                      'Enter the 4 digits code that you received on your email.',
                                  buttonTitle: 'Continue',
                                  buttonColor: AppColors.primary,
                                  builder: (setStateSheet, isEnabled) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 85.h),
                                      OtpWidget(
                                        controller: otpController,
                                        onChanged: (val) {
                                          isEnabled.value =
                                              otpController.text.length == 4;
                                        },
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _password2.controller.clear();
                                    _password3.controller.clear();
                                    showAppBottomSheet(
                                      context: context,
                                      title: 'Reset Password',
                                      subTitle:
                                          'Set the new password for your account so you can login and access all the features.',
                                      buttonTitle: 'Update Passwoed',
                                      buttonColor: AppColors.primary,
                                      builder:
                                          (
                                            setStateSheet,
                                            isEnabled,
                                          ) => Form(
                                            key: _key3,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 29.h),
                                                AppTextField(
                                                  controller:
                                                      _password2.controller,
                                                  validator: (val) =>
                                                      AuthValidators.password(
                                                        context,
                                                        val,
                                                      ),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.deny(
                                                      RegExp(r'\s'),
                                                    ),
                                                  ],
                                                  onChanged: (_) {
                                                    isEnabled.value =
                                                        _resetPasswordValid;
                                                  },

                                                  obscureText: isObscure2,
                                                  hintText: 'New Password',
                                                  prefixIcon: Icon(
                                                    Icons.lock,
                                                    color: Colors.grey[600],
                                                  ),
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      setStateSheet(() {
                                                        isObscure2 =
                                                            !isObscure2;
                                                      });
                                                    },
                                                    child: Icon(
                                                      isObscure2
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 24.h),
                                                AppTextField(
                                                  controller:
                                                      _password3.controller,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (val) =>
                                                      AuthValidators.confirmPassword(
                                                        context,
                                                        val,
                                                        _password2
                                                            .controller
                                                            .text,
                                                      ),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.deny(
                                                      RegExp(r'\s'),
                                                    ),
                                                  ],
                                                  onChanged: (_) {
                                                    isEnabled.value =
                                                        _resetPasswordValid;
                                                  },

                                                  obscureText: isObscure3,
                                                  hintText: 'Re-enter Passwoed',
                                                  prefixIcon: Icon(
                                                    Icons.lock,
                                                    color: Colors.grey[600],
                                                  ),
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      setStateSheet(() {
                                                        isObscure3 =
                                                            !isObscure3;
                                                      });
                                                    },

                                                    child: Icon(
                                                      isObscure3
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      onPressed: () {
                                        if (_key3.currentState!.validate()) {
                                          Navigator.pop(context);
                                          Navigator.of(
                                            context,
                                          ).pushAndRemoveUntil(
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const VerificationSuccessPage(),
                                            ),
                                            (route) => false,
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              }
                            },
                          );
                        },
                        child: Text(
                          'Forget Password?',
                          style: AppTexts.b4Body.copyWith(
                            color: AppColors.primary,
                            fontSize: 12.sp,
                          ),
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
                              }
                            }
                          : null,
                      color: !isButtonEnabled ? Colors.grey : null,
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: AlignmentGeometry.center,
                      child: Text(
                        'OR',
                        style: AppTexts.h4Heading.copyWith(
                          color: Color(0xFF858585),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: AlignmentGeometry.center,
                      child: SizedBox(
                        height: 60.r,
                        width: 60.r,
                        child: Image.asset('assets/images/google_icon.png'),
                      ),
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
