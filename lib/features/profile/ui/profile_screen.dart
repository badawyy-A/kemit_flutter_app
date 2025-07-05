import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/profile/ui/widgets/profile_screen_body.dart';

import '../logic/update_user_cubit/update_user_cubit.dart';
import '../logic/update_user_image_cubit/update_user_image_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UpdateUserCubit>()),
        BlocProvider(create: (context) => getIt<UpdateUserImageCubit>()),
      ],
      child: ProfileScreenBody(),
    );
  }
}