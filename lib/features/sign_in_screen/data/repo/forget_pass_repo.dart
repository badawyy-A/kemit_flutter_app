import 'package:morshd/core/mycore/networking/api_result.dart';
import '../../../../core/mycore/networking/api_error_handler.dart';
import '../../../../core/mycore/networking/api_service.dart';
import '../models/forget_password/forget_pass_email_request_body.dart';
import '../models/forget_password/forget_pass_response.dart';

class ForgetPassRepo {
  final ApiService _apiService;

  ForgetPassRepo(this._apiService);

  Future<ApiResult<ForgetPassResponse>> forget(
    ForgetPassEmailRequestBody forgetPassEmailRequestBody,
  ) async {
    try {
      final response = await _apiService.forgetPassword(
        forgetPassEmailRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
