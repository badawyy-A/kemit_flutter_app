import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/mycore/helper/constants.dart';
import '../../../../core/mycore/helper/shared_pref_helper.dart';
import '../../../../core/mycore/logic/user_cubit/user_cubit.dart';
import '../../../../core/mycore/models/user_model.dart';
import '../../../../core/mycore/networking/dio_factory.dart';
import '../../data/models/login/login_request_body.dart';
import '../../data/repo/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepo, this.userCubit) : super(LoginState.initial());
  final LoginRepo _loginRepo;
  final UserCubit userCubit;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (loginResponse) async {
        await saveUserToken(loginResponse.token ?? '');
         final userModel = UserModel.fromJson(loginResponse.data.toJson());
        log("👤 Login data: ${loginResponse.data.toJson()}");
         userCubit.setUser(userModel);
         await saveUserDataLocally(userModel);

        emit(LoginState.success(loginResponse));
      },
      failure: (apiErrorModel) {
        emit(LoginState.error(apiErrorModel));
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
