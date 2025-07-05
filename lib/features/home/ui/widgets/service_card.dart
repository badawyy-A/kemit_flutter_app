import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/home/ui/widgets/service_details.dart';

import '../../data/models/service_model.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.serviceCardModel,
  });
  final ServiceCardModel serviceCardModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceDetails(
              category: serviceCardModel.title, 
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              serviceCardModel.icon,
              size: 40.r,
              color: Color(0xffcea16e),
            ),
            SizedBox(height: 16.h),
            Text(
              serviceCardModel.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff342613),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
