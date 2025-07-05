import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/mycore/networking/api_error_model.dart';
import '../../data/models/get_nearest_places_response.dart';
part 'get_nearest_places_state.freezed.dart';

@freezed
class GetNearestPlacesState<T> with _$GetNearestPlacesState<T> {
  const factory GetNearestPlacesState.initial() = _Initial;
    const factory GetNearestPlacesState.loading() = Loading;
  const factory GetNearestPlacesState.success(
       List<PlaceData> placeData) =
      Success<T>;
  const factory GetNearestPlacesState.error(ApiErrorModel apiErrorModel) = Error;
}
