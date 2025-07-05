import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:morshd/features/nearest_places/data/repos/get_places_repo.dart';
import 'package:morshd/features/nearest_places/logic/cubit/get_places_state.dart';
import '../../../../core/mycore/helper/constants.dart';
import '../../../../core/mycore/helper/shared_pref_helper.dart';

class GetPlacesCubit extends Cubit<GetPlacesState> {
  GetPlacesCubit(this._getPlacesRepo) : super(GetPlacesState.initial());
  final GetPlacesRepo _getPlacesRepo;

  void getPlaces() async {
    emit(GetPlacesState.loading());
    String token =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);

    final response = await _getPlacesRepo.getPlaces(token);

    response.when(success: (getPlacesResponse) {
      log("Success: ${getPlacesResponse.data.length} places");
      emit(GetPlacesState.success(getPlacesResponse.data));
    }, failure: (apiErrorModel) {
      log("Failure: ${apiErrorModel.message}");
      emit(GetPlacesState.error(apiErrorModel));
    });
  }
}
