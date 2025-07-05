import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/features/sign_up_screen/ui/verify_account/verify_account_screen_body.dart';

import '../../../../core/mycore/di/service_locator.dart';
import '../../logic/sign_up_cubit/sign_up_cubit.dart';
import '../../logic/verify_account_cubit/verify_account_cubit.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key, required this.signUpCubit});
  final SignUpCubit signUpCubit ;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => getIt<VerifyAccountCubit>()),
      BlocProvider.value(value: signUpCubit),
    ], child: VerifyAccountScreenBody());
  }
}
