import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/core/helper/app_regex.dart';
import 'package:morshd/core/widgets/app_elevated_button.dart';
import 'package:morshd/core/widgets/app_text_form_field.dart';
import '../../logic/sign_up_cubit/sign_up_cubit.dart';

class FormSignUp extends StatefulWidget {
  const FormSignUp({super.key});

  @override
  State<FormSignUp> createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> {
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignUpCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'first name',
            suffixIcon: Icon(Icons.person, size: 22.w),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First Name is required';
              }
              if (value.length < 3) {
                return 'First Name must be at least 3 characters';
              }
              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                return 'First Name must contain only letters';
              }
              return null;
            },
            controller: context.read<SignUpCubit>().firstNameController,
          ),
          AppTextFormField(
            hintText: 'last name',
            suffixIcon: Icon(Icons.person, size: 22.w),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Last Name is required';
              }
              if (value.length < 3) {
                return 'Last Name must be at least 3 characters';
              }
              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                return 'Last Name must contain only letters';
              }
              return null;
            },
            controller: context.read<SignUpCubit>().lastNameController,
          ),
          AppTextFormField(
            hintText: 'user name',
            suffixIcon: Icon(Icons.person, size: 22.w),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'User Name is required';
              }
              if (value.length < 3) {
                return 'User Name must be at least 3 characters';
              }
              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                return 'User Name must contain only letters';
              }
              return null;
            },
            controller: context.read<SignUpCubit>().userNameController,
          ),
          AppTextFormField(
            hintText: 'email',
            suffixIcon: Icon(Icons.email, size: 22.w),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              } else if (!AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email';
              } else if (!value.startsWith(RegExp(r'^[a-zA-Z]')) ||
                  !value.endsWith('@gmail.com')) {
                return 'email must start with a character, match\nthe \'@\' symbol, and end with \'gmail.com\'';
              }
              return null;
            },
            controller: context.read<SignUpCubit>().emailController,
          ),
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
                return 'Password required';
              }
              if (value.length < 8) {
                return 'password must be at least 8 characters';
              }
              if (!AppRegex.isPasswordValid(value)) {
                return 'Password must include an uppercase letter,\nlowercase letter, number, and special character';
              }
              return null;
            },
            controller: context.read<SignUpCubit>().passwordController,
            obscureText: isPasswordVisible,
          ),
          AppTextFormField(
            hintText: 'Confirm password',
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                });
              },
              child: Icon(
                isConfirmPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                size: 22.w,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password Confirmation required';
              }
              if (value !=
                  context.read<SignUpCubit>().passwordController.text) {
                return 'Password Confirmation incorrect';
              }
              return null;
            },
            controller: context.read<SignUpCubit>().passwordConfirmController,
            obscureText: isConfirmPasswordVisible,
          ),
          Gap(25.h),
          AppElevatedButton(
            backgroundColor: const Color(0xffDF713D),
            onPressed: () => validateThenDoSignup(context),
            textColor: Colors.white,
            text: 'Sign Up',
            width: 250.w,
            height: 55.h,
          ),
        ],
      ),
    );
  }

  void validateThenDoSignup(BuildContext context) {
    final form = context.read<SignUpCubit>().formKey.currentState;
    if (form!.validate()) {
      context.read<SignUpCubit>().emitSignupStates();
    }
  }
}
