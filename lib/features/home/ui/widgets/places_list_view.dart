import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/home/ui/widgets/places_list_view_item.dart';
import 'package:morshd/features/nearest_places/data/models/get_places_response.dart';
import '../../tourism_details/ui/tourism_details_screen.dart';

class PlacesListView extends StatelessWidget {
  const PlacesListView({super.key, required this.placesList});
  final List<PlaceModel> placesList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: placesList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => TourismDetailsScreen(
                  placeModel: placesList[index],
                  index: index,
                ),
              ));
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: PlacesListViewItem(
                placeModel: placesList[index],
              ),
            ));
      },
    );
  }
}
