import 'package:morshd/core/mycore/networking/api_service.dart';
import '../../../../core/mycore/networking/api_error_handler.dart';
import '../../../../core/mycore/networking/api_result.dart';
import '../models/create_report/create_report_request_body.dart';
import '../models/create_report/create_report_response.dart';

class CreateReportRepo {
  final ApiService _apiService;

  CreateReportRepo(this._apiService);

  Future<ApiResult<CreateReportResponse>> createReport(
    CreateReportRequestBody createReportRequestBody,
    String token,
  ) async {
    try {
      final response = await _apiService.createReport(
        token,
        createReportRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
