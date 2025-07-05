import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/mycore/helper/constants.dart';
import '../../../../core/mycore/helper/shared_pref_helper.dart';
import '../../data/models/create_new_password/create_new_password_request_body.dart';
import '../../data/repo/create_new_password_repo.dart';
import 'create_new_password_state.dart';

class CreateNewPasswordCubit extends Cubit<CreateNewPasswordState> {
  CreateNewPasswordCubit(this._createNewPasswordRepo)
      : super(CreateNewPasswordState.initial());

  final CreateNewPasswordRepo _createNewPasswordRepo;

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> emitCreateNewPasswordStates() async {
    emit(const CreateNewPasswordState.loading());

    String token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.resetToken,
    );

    final response = await _createNewPasswordRepo.createNewPassword(
      CreateNewPasswordRequestBody(
        newPassword: newPasswordController.text,
        passwordConfirm: passwordConfirmController.text,
      ),
      token,
    );

    response.when(
      success: (createNewPasswordResponse) {
        emit(CreateNewPasswordState.success(createNewPasswordResponse));
      },
      failure: (apiErrorModel) {
        emit(CreateNewPasswordState.error(apiErrorModel));
      },
    );
  }
}
