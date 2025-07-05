import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/settings/ui/widgets/settings_screen_body.dart';
import '../logic/create_report_cubit/create_report_cubit.dart';
import '../logic/update_report_cubit/update_report_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<CreateReportCubit>()),
        BlocProvider(create: (context) => getIt<UpdateReportCubit>()),
       
      ],
      child: const SettingsScreenBody(),
    );
  }
}
