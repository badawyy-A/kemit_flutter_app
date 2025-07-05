import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/home/ui/widgets/home_screen_header.dart';
import 'package:morshd/features/home/ui/widgets/service_grid_view.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeScreenHeader(),
            SizedBox(height: 20.h),
            ServiceGridView(),
          ],
        ),
      ),
    );
  }
}
