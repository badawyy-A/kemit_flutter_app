import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/sign_in_screen/ui/widgets/forget_password/verify_password_screen.dart';
import '../../../logic/forget_pass_cubit/forget_password_cubit.dart';
import '../../../logic/forget_pass_cubit/forget_password_state.dart';

class ForgetPassBlocListner extends StatelessWidget {
  const ForgetPassBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            _showLoadingDialog(context);
          },
          success: (forgetPassRepo) {
            _closeDialog(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => VerifyPasswordScreen(
                      forgetPasswordCubit:
                          context.read<ForgetPasswordCubit>())),
            );
          },
          error: (apiErrorModel) {
            _closeDialog(context);
            _showErrorDialog(
              context,
              apiErrorModel.message ?? "An error occurred",
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(color: Color(0xffdf723d)),
      ),
    );
  }

  void _closeDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 28),
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
        content: Text(message, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
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
