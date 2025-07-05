import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/features/settings/logic/create_report_cubit/create_report_state.dart';

import '../../../../core/mycore/helper/constants.dart';
import '../../../../core/mycore/helper/shared_pref_helper.dart';
import '../../data/models/create_report/create_report_request_body.dart';
import '../../data/repos/create_report_repo.dart';

class CreateReportCubit extends Cubit<CreateReportState> {
  CreateReportCubit(this._createReportRepo)
      : super(CreateReportState.initial());

  final CreateReportRepo _createReportRepo;

  TextEditingController review = TextEditingController();

  void emitCreateReportStates(dynamic ratings, String studentId) async {
    emit(CreateReportState.loading());

    String token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );

    final response = await _createReportRepo.createReport(
      CreateReportRequestBody(
        title: review.text,
        ratings: ratings,
        userId: studentId,
      ),
      token,
    );
    response.when(
      success: (createReportResponse) async {
        await SharedPrefHelper.setSecuredString(
          SharedPrefKeys.reportId,
          createReportResponse.data.id,
        );
        log(
          "Saved ReportId: ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.reportId)}",
        );
        emit(CreateReportState.success(createReportResponse));
      },
      failure: (apiErrorModel) {
        emit(CreateReportState.error(apiErrorModel));
      },
    );
  }
}
