import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/sign_in_screen/logic/login_cubit/login_cubit.dart';
import 'package:morshd/features/sign_in_screen/ui/sign_in_screen_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>getIt <LoginCubit>(),
      child: SignInScreenBody(),
    );
  }
}
