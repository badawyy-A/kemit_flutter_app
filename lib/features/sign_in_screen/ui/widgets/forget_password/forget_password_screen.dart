import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/sign_in_screen/logic/forget_pass_cubit/forget_password_cubit.dart';
import 'package:morshd/features/sign_in_screen/ui/widgets/forget_password/forget_pass_screen_body.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => getIt<ForgetPasswordCubit>(),
      ),
      // BlocProvider(
      //   create: (context) => getIt<VerifyPasswordCubit>(),
      // ),
      //  BlocProvider(
      //   create: (context) => SubjectBloc(),  
      // ),
    ], child: ForgetPassScreenBody());
  }
}
