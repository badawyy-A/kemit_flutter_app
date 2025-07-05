import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/sign_in_screen/logic/forget_pass_cubit/forget_password_cubit.dart';
import 'package:morshd/features/sign_in_screen/logic/verify_pass_cubit/verify_password_cubit.dart';
import 'package:morshd/features/sign_in_screen/ui/widgets/forget_password/otp_verification.dart';

class VerifyPasswordScreen extends StatelessWidget {
  const VerifyPasswordScreen({
    super.key,
    required this.forgetPasswordCubit,
  });
  final ForgetPasswordCubit forgetPasswordCubit;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>getIt <VerifyPasswordCubit>(),
        ),
        BlocProvider.value(
          value: forgetPasswordCubit,
        ),
      ],
    child: OtpVerification());
  }
}
