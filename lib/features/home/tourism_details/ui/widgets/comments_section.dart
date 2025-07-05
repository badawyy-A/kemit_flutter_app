import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/home/tourism_details/logic/tourism_details_provider.dart';

class CommentsSection extends ConsumerWidget {
  final String placeId;

  const CommentsSection({
    required this.placeId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsData = ref.watch(getAllTourism(placeId));

    return commentsData.when(
      data: (data) {
        return data.when(
          success: (details) {
            if (details.isEmpty) {
              return Center(
                child: Text(
                  'No Comments',
                  style: TextStyle(
                    color: const Color(0xffCEA16E),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: details.length,
              itemBuilder: (context, index) {
                return buildFacebookStyleComment(details[index]);
              },
            );
          },
          failure: (failure) {
            return Center(
              child: Text(
                'Failed to load comments',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.sp,
                ),
              ),
            );
          },
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(
          'Error loading comments',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.sp,
          ),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Color(0xffCEA16E),
        ),
      ),
    );
  }

  Widget buildFacebookStyleComment(dynamic comment) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, size: 20.sp, color: Colors.white),
            ),
            Gap(10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        comment.reviewerName.toString(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Gap(5.h),

                  Text(
                    comment.comment.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 