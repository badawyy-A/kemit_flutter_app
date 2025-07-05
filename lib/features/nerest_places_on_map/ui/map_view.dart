import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:morshd/features/nerest_places_on_map/logic/get_nearest_places_cubit/get_nearest_places_cubit.dart';
import 'package:morshd/features/nerest_places_on_map/logic/get_nearest_places_cubit/get_nearest_places_state.dart'
    as places_state;

import '../data/models/get_nearest_places_response.dart';
import '../service/location_service.dart';

class MapView extends StatefulWidget {
  const MapView({
    super.key,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  LatLng _initialPosition = const LatLng(31.2685013, 32.2658171);

  void _updatePlacesMarkers(List<PlaceData> placesData) {
    final newMarkers = <Marker>{};
    for (var place in placesData) {
      if (place.position != null) {
        final lat = place.position!.lat;
        final lng = place.position!.lng;
        newMarkers.add(
          Marker(
            markerId: MarkerId(UniqueKey().toString()),
            position: LatLng(double.parse(lat!), double.parse(lng!)),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              HSVColor.fromColor(Color(0xffDF713D)).hue,
            ),
            infoWindow: InfoWindow(
              title: '${place.name} ',
              snippet: place.city,
            ),
          ),
        );
      }
    }
    _markers.clear();
    _markers.addAll(newMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNearestPlacesCubit,
        places_state.GetNearestPlacesState>(
      builder: (context, state) {
        if (state is places_state.Loading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color(0xffDF713D),
          ));
        } else if (state is places_state.Error) {
          return const Center(child: Text('Error loading doctors'));
        } else if (state is places_state.Success) {
          final places = state.placeData;
          _updatePlacesMarkers(places);
          if (_markers.isNotEmpty) {
            _initialPosition = _markers.first.position;
          }
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SizedBox.expand(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 14.0,
                ),
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  LocationService.moveToUserLocation(context, mapController);
                  if (_markers.isNotEmpty) {
                    mapController.animateCamera(
                      CameraUpdate.newLatLngZoom(_markers.first.position, 16),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
