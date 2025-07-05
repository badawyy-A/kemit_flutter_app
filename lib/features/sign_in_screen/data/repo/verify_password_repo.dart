import '../../../../core/mycore/networking/api_error_handler.dart';
import '../../../../core/mycore/networking/api_result.dart';
import '../../../../core/mycore/networking/api_service.dart';
import '../models/verify_password/verify_password_request_body.dart';
import '../models/verify_password/verify_password_response.dart';

class VerifyPasswordRepo {
  final ApiService _apiService;

  VerifyPasswordRepo(this._apiService);

  Future<ApiResult<VerifyPasswordResponse>> forget(
    VerifyPasswordRequestBody verifyPasswordRequestBody,
    String token,
  ) async {
    try {
      final response = await _apiService.verifyPassword(
        verifyPasswordRequestBody,
        token,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
