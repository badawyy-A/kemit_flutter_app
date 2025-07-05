import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/settings/ui/widgets/update_pass_bloc_listener.dart';

import '../../../../core/helper/app_regex.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../logic/update_pass_cubit/update_pass_cubit.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool isOldPasswordVisible = true;
  bool isNewPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdatePassCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change your password',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffDF713D)),
              ),
              SizedBox(height: 20.h),
              AppTextFormField(
                hintText: 'Old password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isOldPasswordVisible = !isOldPasswordVisible;
                    });
                  },
                  child: Icon(
                    isOldPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 22.w,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Old password is required';
                  }
                  return null;
                },
                controller: cubit.oldPassController,
                obscureText: isOldPasswordVisible,
              ),
              SizedBox(height: 10.h),
              AppTextFormField(
                hintText: 'New password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isNewPasswordVisible = !isNewPasswordVisible;
                    });
                  },
                  child: Icon(
                    isNewPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 22.w,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'New password is required';
                  } else if (!AppRegex.isPasswordValid(value)) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                controller: cubit.newPassController,
                obscureText: isNewPasswordVisible,
              ),
              SizedBox(height: 60.h),
              Center(
                child: AppElevatedButton(
                  backgroundColor: const Color(0xffDF713D),
                  onPressed: () {
                    validateThenUpdatePass(context);
                  },
                  textColor: Colors.white,
                  text: 'Change Password',
                  width: 150.w,
                  height: 50.h,
                ),
              ),
              UpdatePassBlocListener(),
            ],
          ),
        ),
      ),
    );
  }

  void validateThenUpdatePass(BuildContext context) {
    final cubit = context.read<UpdatePassCubit>();
    final form = cubit.formKey.currentState;
    if (form!.validate()) {
      cubit.emitUpdatePassStates();
    }
  }
}
