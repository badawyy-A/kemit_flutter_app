import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpField extends StatelessWidget {
  const OtpField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 55.w,
      height: 55.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffe5e9ef),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.transparent),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Color(0xffe5e9ef),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Color(0xffdf723d), width: 2),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Form(
        //  key: context.read<VerifyPasswordCubit>().formKey,
        child: Pinput(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Verification code is required';
            }
            return null;
          },
          controller: controller,
          length: 6,
          showCursor: true,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
        ),
      ),
    );
  }
}
