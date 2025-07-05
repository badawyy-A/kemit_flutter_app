import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/sign_in_screen/ui/widgets/forget_password/forget_pass_bloc_listner.dart';
import '../../../../../core/helper/app_regex.dart';
import '../../../../../core/widgets/app_elevated_button.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../logic/forget_pass_cubit/forget_password_cubit.dart';

class ForgetPassScreenBody extends StatelessWidget {
  const ForgetPassScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: context.read<ForgetPasswordCubit>().formKey,
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
                          'Forget Password',
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
                      'Please enter your email address to reset your password',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    AppTextFormField(
                      hintText: 'Email',
                      suffixIcon: Icon(
                        Icons.email,
                        size: 22.w,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email required';
                        }
                        if (!AppRegex.isEmailValid(value)) {
                          return 'Invalid email';
                        }
                        if (!value.startsWith(RegExp(r'^[a-zA-Z]')) ||
                            !value.endsWith('@gmail.com')) {
                          return 'Email must start with a character and end with \'gmail.com\'';
                        }
                      },
                      controller:
                          context.read<ForgetPasswordCubit>().emailController,
                    ),
                    SizedBox(height: 44.h),
                    AppElevatedButton(
                      backgroundColor: const Color(0xffDF713D),
                      onPressed: () {
                        validateThenSendCode(context);
                      },
                      textColor: Colors.white,
                      text: 'Send Code',
                      width: 250.w,
                      height: 55.h,
                    ),
                    ForgetPassBlocListner()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateThenSendCode(BuildContext context) {
    final form = context.read<ForgetPasswordCubit>().formKey.currentState;
    if (form!.validate()) {
      context.read<ForgetPasswordCubit>().emitForgetPasswordStates();
    }
  }
}
