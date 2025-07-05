import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/nearest_places/data/models/get_places_response.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacesListViewItem extends StatelessWidget {
  const PlacesListViewItem({super.key, required this.placeModel});
  final PlaceModel placeModel;
  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.maxFinite,
            height: 290.h,
            margin: EdgeInsets.symmetric(
              horizontal: 20.w,
             // vertical: index == 0 ? 0 : 10.h,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffCEA16E),
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              border: Border.all(color: Colors.grey, width: 1.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 5.r,
                  spreadRadius: 1.r,
                  offset: const Offset(0.0, 3.0),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage((placeModel.images)),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 20.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              placeModel.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Gap(5.w),
                          GestureDetector(
                            onTap: () async {
                              String url = placeModel.location;
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              }
                            },
                            child: Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                              size: 15.w,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]
            )
          
    );
  }
}