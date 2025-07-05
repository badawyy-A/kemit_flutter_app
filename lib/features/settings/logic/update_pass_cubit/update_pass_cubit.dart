import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/features/settings/data/models/update_password/update_pass_request_body.dart';
import 'package:morshd/features/settings/data/repos/update_pass_repo.dart';
import 'package:morshd/features/settings/logic/update_pass_cubit/update_pass_state.dart';
import '../../../../core/mycore/helper/constants.dart';
import '../../../../core/mycore/helper/shared_pref_helper.dart';
import '../../../../core/mycore/networking/dio_factory.dart';

class UpdatePassCubit extends Cubit<UpdatePassState> {
  UpdatePassCubit(
    this._updatePassRepo,
  ) : super(UpdatePassState.initial());
  final UpdatePassRepo _updatePassRepo;

  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitUpdatePassStates() async {
    emit(UpdatePassState.loading());
    String token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    final response = await _updatePassRepo.updatePassword(
      UpdatePassRequestBody(
          oldPassword: oldPassController.text,
          newPassword: newPassController.text),
      token,
    );
    response.when(
      success: (updatePassResponse) async {
        await saveUserToken(updatePassResponse.token ?? '');

        emit(UpdatePassState.success(updatePassResponse));
      },
      failure: (apiErrorModel) {
        emit(UpdatePassState.error(apiErrorModel));
      },
    );
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterSignUp(token);
    log(
      "Saved NewToken: ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}",
    );
  }
}
