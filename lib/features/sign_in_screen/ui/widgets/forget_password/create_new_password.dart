import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/sign_in_screen/logic/create_new_password_cubit/create_new_password_cubit.dart';
import 'package:morshd/features/sign_in_screen/ui/widgets/forget_password/create_new_password_screen.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>getIt <CreateNewPasswordCubit>(),
      child: const CreateNewPasswordScreen(),
    );
  }
}
