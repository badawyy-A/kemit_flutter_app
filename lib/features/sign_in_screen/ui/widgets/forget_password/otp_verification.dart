import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/sign_in_screen/logic/forget_pass_cubit/forget_password_cubit.dart';
import 'package:morshd/features/sign_in_screen/logic/verify_pass_cubit/verify_password_cubit.dart';
import 'package:morshd/features/sign_in_screen/ui/widgets/forget_password/otp_field.dart';
import 'package:morshd/features/sign_in_screen/ui/widgets/forget_password/verify_password_bloc_listner.dart';
import '../../../../../core/widgets/app_elevated_button.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: context.read<VerifyPasswordCubit>().formKey,
          child: Column(
            children: [
              Image.asset(
                'assets/images/top_image_home.webp',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        const Text(
                          'OTP Verification',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffdf723d),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    const Text(
                      'Please enter the OTP sent to your email address',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    OtpField(
                      controller: context.read<VerifyPasswordCubit>().otpField,
                    ),
                    SizedBox(height: 44.h),
                    AppElevatedButton(
                      backgroundColor: const Color(0xffDF713D),
                      onPressed: () {
                        validateThenVerify(context);
                      },
                      textColor: Colors.white,
                      text: 'Send Code',
                      width: 250.w,
                      height: 55.h,
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Didn\'t receive the code?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ForgetPasswordCubit>()
                                .emitForgetPasswordStates();
                          },
                          child: const Text(
                            'Resend',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffdf723d),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              VerifyPassBlocListner(),
            ],
          ),
        ),
      ),
    );
  }

  void validateThenVerify(BuildContext context) {
    final form = context.read<VerifyPasswordCubit>().formKey.currentState;
    if (form!.validate()) {
      context.read<VerifyPasswordCubit>().emitVerifyPasswordStates();
    }
  }
}
