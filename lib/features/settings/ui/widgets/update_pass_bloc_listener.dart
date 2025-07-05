import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/home/ui/home.dart';
import 'package:morshd/features/settings/logic/update_pass_cubit/update_pass_cubit.dart';
import 'package:morshd/features/settings/logic/update_pass_cubit/update_pass_state.dart';
import '../../../../../core/mycore/networking/api_error_model.dart';

class UpdatePassBlocListener extends StatelessWidget {
  const UpdatePassBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePassCubit, UpdatePassState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffdf723d),
                ),
              ),
            );
          },
          success: (createNewPasswordRepo) {
            if (Navigator.canPop(context)) {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop(); // Close loading dialog
            }
            setupSuccessState(context);
          },
          error: (apiErrorModel) {
            if (Navigator.canPop(context)) {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop(); // Close loading dialog
            }
            setupErrorState(
              context,
              apiErrorModel,
            ); // Show error using AwesomeDialog
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 28),
            const SizedBox(width: 8),
            Text(
              "Error",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(apiErrorModel.message!, style: TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Got it",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setupSuccessState(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            Text(
              "Success",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your password has been changed successfully",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const Home()));
            },
            child: Text(
              "Got it",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
