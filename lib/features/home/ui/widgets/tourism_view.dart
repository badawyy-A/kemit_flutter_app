import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/home/ui/widgets/get_places_bloc_builder.dart';

class TourismView extends StatefulWidget {
  const TourismView({super.key, required this.category});
  final String category;

  @override
  State<TourismView> createState() => _TourismViewState();
}

class _TourismViewState extends State<TourismView> {
  int selectedView = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xffCEA16E),
                    size: 25,
                  ),
                ),
                Text(
                  ' Top ${widget.category} Places ',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 169, 128, 81),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Gap(20.h),
          Expanded(
            child: GetPlacesBlocBuilder(selectedCategory: widget.category),
          ),
        ],
      ),
    );
  }
}
