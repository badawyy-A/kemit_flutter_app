import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:morshd/core/mycore/networking/api_error_model.dart';
import '../../data/models/get_places_response.dart';
part 'get_places_state.freezed.dart';
@freezed
class GetPlacesState<T> with _$GetPlacesState<T> {
  const factory GetPlacesState.initial() = _Initial;
  const factory GetPlacesState.loading() = Loading;
  const factory GetPlacesState.success(List<PlaceModel> myPlaces) = Success;
  const factory GetPlacesState.error(ApiErrorModel apiErrorModel) = Error;
}
