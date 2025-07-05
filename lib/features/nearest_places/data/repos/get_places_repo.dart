import 'package:morshd/core/mycore/networking/api_error_handler.dart';
import 'package:morshd/core/mycore/networking/api_result.dart';
import 'package:morshd/core/mycore/networking/api_service.dart';
import 'package:morshd/features/nearest_places/data/models/get_places_response.dart';

class GetPlacesRepo {
  final ApiService _apiService;
  GetPlacesRepo(this._apiService);

  Future<ApiResult<GetPlacesResponse>> getPlaces(String token) async {
    try {
      final response = await _apiService.getAllPlaces(token);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
