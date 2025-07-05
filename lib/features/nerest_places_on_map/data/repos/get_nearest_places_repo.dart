import 'package:morshd/features/nerest_places_on_map/data/models/get_nearest_places_response.dart';

import '../../../../core/mycore/networking/api_error_handler.dart';
import '../../../../core/mycore/networking/api_result.dart';
import '../../../../core/mycore/networking/api_service.dart';

class GetNearestPlacesRepo {
  final ApiService _apiService;

  GetNearestPlacesRepo(this._apiService);

  Future<ApiResult<GetNearestPlacesResponse>> getNearestPlaces(
      double longitude, double latitude, String token) async {
    try {
      final response =
          await _apiService.getNearestPlaces(token, longitude, latitude);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
