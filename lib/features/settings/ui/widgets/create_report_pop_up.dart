import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/core/mycore/models/user_model.dart';

import '../../../../core/mycore/logic/user_cubit/user_cubit.dart';
import '../../logic/create_report_cubit/create_report_cubit.dart';
import '../../logic/update_report_cubit/update_report_cubit.dart';
import 'show_overlay_message.dart';

void createReportPopup(BuildContext context, UserModel user) {
  final createReportCubit = context.read<CreateReportCubit>();
  final updateReportCubit = context.read<UpdateReportCubit>();
  final rootContext = context;
  final controller =
      user.createReport ? updateReportCubit.review : createReportCubit.review;
  double rating = 0;

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: const Color(0xFFF9F9F9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: Colors.amber, size: 25),
                    onRatingUpdate: (value) {
                      setState(() {
                        rating = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Rate Your Experience",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: "Type your feedback!...",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.sp,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: (rating == 0 || controller.text.isEmpty)
                              ? null
                              : () async {
                                  if (user.createReport) {
                                    //  Use UpdateReportCubit

                                    updateReportCubit.emitUpdateReportStates(
                                      rating,
                                    );
                                  } else {
                                    // Use CreateReportCubit
                                    createReportCubit.emitCreateReportStates(
                                      rating,
                                      user.id,
                                    );
                                    final updatedUser = user.copyWith(
                                      createReport: true,
                                    );
                                    context.read<UserCubit>().setUser(
                                          updatedUser,
                                        );
                                    await saveUserDataLocally(updatedUser);
                                  }
                                  Navigator.of(context).pop();
                                  Future.delayed(
                                    Duration(milliseconds: 300),
                                    () {
                                      showOverlayMessage(
                                        rootContext,
                                        "Thanks for your feedback!",
                                      );
                                    },
                                  );
                                },
                          icon: Icon(
                            Icons.send,
                            color: (rating == 0 || controller.text.isEmpty)
                                ? Colors.grey
                                : const Color(0xFFDF713D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
