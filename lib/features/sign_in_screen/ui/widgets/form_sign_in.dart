import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/core/widgets/app_elevated_button.dart';
import 'package:morshd/core/widgets/app_text_form_field.dart';
import 'package:morshd/features/sign_in_screen/ui/widgets/forget_password.dart';
import '../../../../core/helper/app_regex.dart';
import '../../logic/login_cubit/login_cubit.dart';

class FormSignIn extends StatefulWidget {
  const FormSignIn({super.key});

  @override
  State<FormSignIn> createState() => _FormSignInState();
}

class _FormSignInState extends State<FormSignIn> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Email',
            suffixIcon: Icon(
              Icons.email,
              size: 22.w,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              } else if (!AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            controller: context.read<LoginCubit>().emailController,
          ),
          Gap(35.h),
          AppTextFormField(
            hintText: 'password',
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              child: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                size: 22.w,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              } else if (!AppRegex.isPasswordValid(value)) {
                return 'Please enter a valid password';
              }
              return null;
            },
            controller: context.read<LoginCubit>().passwordController,
            obscureText: isPasswordVisible,
          ),
          SizedBox(height: 18.h),
          const ForgetPassword(),
          Gap(30.h),
          AppElevatedButton(
            backgroundColor: const Color(0xffDF713D),
            onPressed: () => validateThenDoLogin(context),
            textColor: Colors.white,
            text: 'Sign In',
            width: 250.w,
            height: 55.h,
          ),
        ],
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    final form = context.read<LoginCubit>().formKey.currentState;
    if (form!.validate()) {
      context.read<LoginCubit>().emitLoginStates();
    }
  }
}
