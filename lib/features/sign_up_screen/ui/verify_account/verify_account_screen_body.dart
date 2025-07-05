import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/sign_up_screen/logic/sign_up_cubit/sign_up_cubit.dart';
import 'package:morshd/features/sign_up_screen/ui/verify_account/verify_account_opt_code.dart';
import '../../../../../../core/widgets/app_elevated_button.dart';
import '../../logic/verify_account_cubit/verify_account_cubit.dart';
import 'verify_account_bloc_listener.dart';

class VerifyAccountScreenBody extends StatelessWidget {
  const VerifyAccountScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                        'Verify Account',
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
                    'Enter the 6-digit code we just sent on your email address',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  VerifyAccountOptCode(
                      controller: context.read<VerifyAccountCubit>().otpField),
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
                          context.read<SignUpCubit>().emitSignupStates();
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
                  ),
                  VerifyAccountBlocListner(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateThenVerify(BuildContext context) {
    if (context.read<VerifyAccountCubit>().formKey.currentState!.validate()) {
      context.read<VerifyAccountCubit>().emitVerifyAccountStates();
    }
  }
}
