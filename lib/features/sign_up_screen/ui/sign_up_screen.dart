import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/sign_up_screen/logic/sign_up_cubit/sign_up_cubit.dart';
import 'package:morshd/features/sign_up_screen/ui/sign_up_screen_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignUpCubit>(),
      child: SignUpScreenBody(),
    );
  }
}
