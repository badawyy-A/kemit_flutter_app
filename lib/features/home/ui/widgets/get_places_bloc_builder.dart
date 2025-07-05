import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshd/features/home/ui/widgets/places_list_view.dart';
import 'package:morshd/features/nearest_places/data/models/get_places_response.dart';
import 'package:morshd/features/nearest_places/logic/cubit/get_places_state.dart';
import '../../../nearest_places/logic/cubit/get_places_cubit.dart';

class GetPlacesBlocBuilder extends StatelessWidget {
  const GetPlacesBlocBuilder({super.key, required this.selectedCategory});
  final String selectedCategory;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPlacesCubit, GetPlacesState>(
      buildWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      builder: (context, state) {
        return state.maybeWhen(
          loading: () {
            return setupLoading();
          },
          success: (getAllPlacesData) {
            var placesList = List<PlaceModel>.from(getAllPlacesData!);
            var filteredPlaces = placesList
                .where((place) => place.category == selectedCategory)
                .toList();

            return setupSuccess(filteredPlaces);
          },
          error: (error) {
            return setupError();
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget setupLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: const Color(0xffCEA16E),
        strokeWidth: 2.0,
      ),
    );
  }

  Widget setupSuccess(List<PlaceModel> placesList) {
    return PlacesListView(
      placesList: placesList,
    );
  }

  Widget setupError() {
    return const SizedBox.shrink();
  }
}
