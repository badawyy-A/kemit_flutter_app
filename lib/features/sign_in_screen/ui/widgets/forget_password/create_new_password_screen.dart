import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helper/app_regex.dart';
import '../../../../../core/widgets/app_elevated_button.dart';
import '../../../../../core/widgets/app_text_form_field.dart';
import '../../../logic/create_new_password_cubit/create_new_password_cubit.dart';
import 'create_new_password_bloc_listner.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

bool isPasswordVisible = true;
bool isConfirmPasswordVisible = true;

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: context.read<CreateNewPasswordCubit>().formKey,
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
                          'Create New Password',
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
                      'Your new password must be different from previos used passwords',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    AppTextFormField(
                        hintText: 'password',
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 22.w,
                            )),
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
                        controller: context
                            .read<CreateNewPasswordCubit>()
                            .newPasswordController,
                        obscureText: isPasswordVisible),
                    SizedBox(height: 44.h),
                    AppTextFormField(
                        hintText: 'Confirm password',
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              });
                            },
                            child: Icon(
                              isConfirmPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 22.w,
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password Confirmation required';
                          }
                          if (value !=
                              context
                                  .read<CreateNewPasswordCubit>()
                                  .newPasswordController
                                  .text) {
                            return 'Password Confirmation incorrect';
                          }
                          return null;
                        },
                        controller: context
                            .read<CreateNewPasswordCubit>()
                            .passwordConfirmController,
                        obscureText: isConfirmPasswordVisible),
                    SizedBox(height: 44.h),
                    AppElevatedButton(
                      backgroundColor: const Color(0xffDF713D),
                      onPressed: () {
                        validateThenSendCode(context);
                      },
                      textColor: Colors.white,
                      text: 'Reset Password',
                      width: 250.w,
                      height: 55.h,
                    ),
                    CreateNewPasswordBlocListener(),
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
    final form = context.read<CreateNewPasswordCubit>().formKey.currentState;
    if (form!.validate()) {
      context.read<CreateNewPasswordCubit>().emitCreateNewPasswordStates();
    }
  }
}
