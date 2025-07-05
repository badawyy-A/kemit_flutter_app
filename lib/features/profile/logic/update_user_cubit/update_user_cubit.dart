import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/mycore/helper/constants.dart';
import '../../../../core/mycore/helper/shared_pref_helper.dart';
import '../../data/models/update_user_request_body.dart';
import '../../data/repos/update_user_repo.dart';
import 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit(this._updateUserRepo) : super(UpdateUserState.initial());

  final UpdateUserRepo _updateUserRepo;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  void emitUpdateUserStates({
    required String oldFirstName,
    required String oldLastName,
    required String oldUserName,
    
  }) async {
    emit(const UpdateUserState.loading());
    String token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );

    final response = await _updateUserRepo.updateUser(
      UpdateUserRequestBody(
        firstName: firstNameController.text.isNotEmpty
            ? firstNameController.text
            : oldFirstName,
        lastName: lastNameController.text.isNotEmpty
            ? lastNameController.text
            : oldLastName,
        userName: userNameController.text.isNotEmpty
            ? userNameController.text
            : oldUserName,
      ),
      token,
    );
    response.when(
      success: (updateUserResponse) async {
        emit(UpdateUserState.success(updateUserResponse));
      },
      failure: (apiErrorModel) {
        emit(UpdateUserState.error(apiErrorModel));
      },
    );
  }
}
