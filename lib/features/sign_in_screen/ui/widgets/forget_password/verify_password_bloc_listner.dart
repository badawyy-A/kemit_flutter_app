import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/mycore/networking/api_error_model.dart';
import '../../../logic/verify_pass_cubit/verify_password_cubit.dart';
import '../../../logic/verify_pass_cubit/verify_password_state.dart';
import 'create_new_password.dart';

class VerifyPassBlocListner extends StatelessWidget {
  const VerifyPassBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyPasswordCubit, VerifyPasswordState>(
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
          success: (verifyPasswordResponse) {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const CreateNewPassword()));
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
        backgroundColor: const Color(0xFFF5F5F5),
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
                fontSize: 20.sp,
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
}
