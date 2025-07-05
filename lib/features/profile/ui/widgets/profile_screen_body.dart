import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/profile/ui/widgets/editable_profile_field.dart';
import 'package:morshd/features/profile/ui/widgets/user_profile_pic.dart';
import '../../../../core/mycore/logic/user_cubit/user_cubit.dart';
import '../../../../core/mycore/models/user_model.dart';
import '../../logic/update_user_cubit/update_user_cubit.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state.user;
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final cubit = context.read<UpdateUserCubit>();
    cubit.firstNameController.text = user.firstName;
    cubit.lastNameController.text = user.lastName;
    cubit.userNameController.text = user.userName;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: context.read<UpdateUserCubit>().formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffDF713D),
                    ),
                  ),
                ],
              ),
              Center(child: UserProfilePic()),
              SizedBox(height: 20.h),
              EditableProfileField(
                onCheckPressed: () {
                  validateThenUpdate(context, user);
                },
                controller: cubit.firstNameController,
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
                title: 'First Name',
                value: user.firstName,
              ),
              SizedBox(height: 12.h),
              EditableProfileField(
                onCheckPressed: () {
                  validateThenUpdate(context, user);
                },
                controller: cubit.lastNameController,
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
                title: 'Last Name',
                value: user.lastName,
              ),
              SizedBox(height: 12.h),
              EditableProfileField(
                onCheckPressed: () {
                  validateThenUpdate(context, user);
                },
                controller: cubit.userNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'User Name is required';
                  }
                  if (value.length < 3) {
                    return 'User Name must be at least 3 characters';
                  }

                  return null;
                },
                title: 'User Name',
                value: user.userName,
              ),
              SizedBox(height: 12.h),
              EditableProfileField(
                title: 'Email Address',
                value: user.email,
                check: true,
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  void validateThenUpdate(BuildContext context, UserModel user) async {
    final cubit = context.read<UpdateUserCubit>();
    if (cubit.formKey.currentState!.validate()) {
      context.read<UpdateUserCubit>().emitUpdateUserStates(
            oldFirstName: user.firstName,
            oldLastName: user.lastName,
            oldUserName: user.userName,
          );

      final updatedUser = user.copyWith(
        firstName: cubit.firstNameController.text.isNotEmpty
            ? cubit.firstNameController.text
            : user.firstName,
        lastName: cubit.lastNameController.text.isNotEmpty
            ? cubit.lastNameController.text
            : user.lastName,
        userName: cubit.userNameController.text.isNotEmpty
            ? cubit.userNameController.text
            : user.userName,
      );

      context.read<UserCubit>().setUser(updatedUser);
      saveUserDataLocally(updatedUser);
    }
  }
}
