import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/mycore/helper/constants.dart';
import '../../../../core/mycore/helper/shared_pref_helper.dart';
import '../../../../core/mycore/networking/dio_factory.dart';
import '../../data/models/sign_up/sign_up_request_body.dart';
import '../../data/repo/sign_up_repoo.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signupRepo) : super(SignUpState.initial());

  final SignupRepo _signupRepo;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void emitSignupStates() async {
    emit(const SignUpState.loading());

    final response = await _signupRepo.signup(
      SignupRequestBody(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        userName: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirm: passwordConfirmController.text,
      ),
    );

    response.when(
      success: (signupResponse) async {
        await saveUserToken(signupResponse.token ?? '');
        emit(SignUpState.success(signupResponse));
      },
      failure: (apiErrorModel) {
        emit(SignUpState.error(apiErrorModel));
      },
    );
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterSignUp(token);
    log(
      "Saved Token: ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}",
    );
  }
}
