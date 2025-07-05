import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:morshd/features/nerest_places_on_map/data/repos/get_nearest_places_repo.dart';
import '../../../../core/mycore/helper/constants.dart';
import '../../../../core/mycore/helper/shared_pref_helper.dart';
import '../../service/location_service.dart';
import 'get_nearest_places_state.dart';

class GetNearestPlacesCubit extends Cubit<GetNearestPlacesState> {
  GetNearestPlacesCubit(this._getNearestPlacesRepo)
      : super(GetNearestPlacesState.initial());

  final GetNearestPlacesRepo _getNearestPlacesRepo;

  void getNearestPlaces() async {
    emit(const GetNearestPlacesState.loading());

    // await LocationService.getCurrentLocation();
    if (LocationService.currentPosition == null) {
      log('Location service is disabled');
      return;
    }
    String token =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    final response = await _getNearestPlacesRepo.getNearestPlaces(
      LocationService.currentPosition!.longitude,
      LocationService.currentPosition!.latitude,
      token,
    );
    response.when(
      success: (getNearestPlacesResponse) {
        emit(
            GetNearestPlacesState.success(getNearestPlacesResponse.data ?? []));
      },
      failure: (apiErrorModel) {
        emit(GetNearestPlacesState.error(apiErrorModel));
      },
    );
  }
}
