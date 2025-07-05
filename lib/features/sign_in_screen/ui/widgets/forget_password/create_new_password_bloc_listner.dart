import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/sign_in_screen/ui/sign_in_screen.dart';
import '../../../../../core/mycore/networking/api_error_model.dart';
import '../../../logic/create_new_password_cubit/create_new_password_cubit.dart';
import '../../../logic/create_new_password_cubit/create_new_password_state.dart';

class CreateNewPasswordBlocListener extends StatelessWidget {
  const CreateNewPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateNewPasswordCubit, CreateNewPasswordState>(
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
              "Password has been changed successfully",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const SignInScreen()));
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
