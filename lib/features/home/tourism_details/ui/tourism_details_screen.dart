import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/core/widgets/app_scaffold.dart';

import '../../../nearest_places/data/models/get_places_response.dart';
import 'widgets/add_comment_button.dart';
import 'widgets/image_and_details.dart';

class TourismDetailsScreen extends StatelessWidget {
  final PlaceModel placeModel;
  final int index;
  const TourismDetailsScreen(
      {super.key, required this.placeModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          backgroundColor: const Color(0xffCEA16E),
          centerTitle: true,
          title: Text(
            placeModel.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageAndDetails(
              placeModel: placeModel,
            
            ),
          ],
        ),
      ),
      floatingActionButton: AddCommentButton(
        placeId: placeModel.id,
      ),
    );
  }
}
