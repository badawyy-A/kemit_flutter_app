import 'package:morshd/core/mycore/networking/api_result.dart';

import '../../../../core/mycore/networking/api_error_handler.dart';
import '../../../../core/mycore/networking/api_service.dart';
import '../models/create_new_password/create_new_password_request_body.dart';
import '../models/create_new_password/create_new_password_response.dart';

class CreateNewPasswordRepo {
  final ApiService _apiService;

  CreateNewPasswordRepo(this._apiService);

  Future<ApiResult<CreateNewPasswordResponse>> createNewPassword(
    CreateNewPasswordRequestBody createNewPasswordRequestBody,
    String token,
  ) async {
    try {
      final response = await _apiService.createNewPassword(
        token,
        createNewPasswordRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
