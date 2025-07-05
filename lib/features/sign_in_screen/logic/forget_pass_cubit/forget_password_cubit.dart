import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/mycore/helper/constants.dart';
import '../../../../core/mycore/helper/shared_pref_helper.dart';
import '../../../../core/mycore/networking/dio_factory.dart';
import '../../data/models/forget_password/forget_pass_email_request_body.dart';
import '../../data/repo/forget_pass_repo.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._forgetPassRepo)
      : super(ForgetPasswordState.initial());
  final ForgetPassRepo _forgetPassRepo;
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  

  void emitForgetPasswordStates() async {
   
    emit(const ForgetPasswordState.loading());

    final response = await _forgetPassRepo.forget(
      ForgetPassEmailRequestBody(email: emailController.text),
    );
    response.when(
      success: (forgetPassResponse) async {
        await saveUserToken(forgetPassResponse.token ?? '');
        emit(ForgetPasswordState.success(forgetPassResponse));
      },
      failure: (apiErrorModel) {
        emit(ForgetPasswordState.error(apiErrorModel));
      },
    );
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.resetToken, token);
    DioFactory.setTokenIntoHeaderAfterSignUp(token);
    log(
      "Saved Token: ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.resetToken)}",
    );
  }

}
