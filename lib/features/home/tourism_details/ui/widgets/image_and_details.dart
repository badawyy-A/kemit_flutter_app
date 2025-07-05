import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../nearest_places/data/models/get_places_response.dart';
import 'comments_section.dart';

class ImageAndDetails extends StatelessWidget {
  final PlaceModel placeModel;

  const ImageAndDetails({
    required this.placeModel,
    super.key,
  });

  /// **Function to Open Google Maps**
  Future<void> openGoogleMaps(String location) async {
    final Uri googleMapsUri =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$location");
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      throw 'Could not open the map';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),

          Hero(
            tag: placeModel.id,
            child: Container(
              width: double.maxFinite,
              height: 250.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                image: DecorationImage(
                  image: NetworkImage(placeModel.images),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Gap(15.h),

          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeModel.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Gap(10.h),
                Row(
                  children: [
                    Icon(Icons.location_city,
                        color: Colors.grey.shade700, size: 20.sp),
                    Gap(5.w),
                    Text(
                      placeModel.city,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Gap(5.h),
                GestureDetector(
                  onTap: () => openGoogleMaps(placeModel.location),
                  child: Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.redAccent, size: 20.sp),
                      Gap(5.w),
                      Text(
                        "View on Map",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(10.h),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        color: Colors.grey.shade700, size: 20.sp),
                    Gap(5.w),
                    Text(
                      "Open: ${_formatTime(placeModel.openingTime)} - Close: ${_formatTime(placeModel.closingTime)}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Gap(10.h),
                Row(
                  children: [
                    Icon(Icons.attach_money, color: Colors.green, size: 20.sp),
                    Gap(5.w),
                    Text(
                      "Entry Fee: ${placeModel.entryFee}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Gap(10.h),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orangeAccent, size: 20.sp),
                    Gap(5.w),
                    Text(
                      "Rating: ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        placeModel.rating.toInt(),
                        (index) => Icon(Icons.star,
                            color: Colors.orangeAccent, size: 16.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(20.h),

          // Comments Section
          //   CommentsSection(placeId: placeModel.id),
        ],
      ),
    );
  }

  /// **Time Formatting Function**
  String _formatTime(DateTime time) {
    return "${time.hour % 12 == 0 ? 12 : time.hour % 12}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}";
  }
}
