import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/sign_in_screen/ui/sign_in_screen_body.dart';
import 'package:morshd/features/sign_up_screen/ui/widgets/form_sign_up.dart';

import '../../../sign_in_screen/ui/sign_in_screen.dart';

class BoxWidgetsSignUp extends StatelessWidget {
  const BoxWidgetsSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 550.h,
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 25.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25.sp,
              ),
            ),
            Gap(10.h),
            const FormSignUp(),
            Gap(18.h),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: const Color(0xffDF713D),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SignInScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
