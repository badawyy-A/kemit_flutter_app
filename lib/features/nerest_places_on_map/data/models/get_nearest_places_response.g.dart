// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_nearest_places_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNearestPlacesResponse _$GetNearestPlacesResponseFromJson(
        Map<String, dynamic> json) =>
    GetNearestPlacesResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PlaceData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNearestPlacesResponseToJson(
        GetNearestPlacesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

PlaceData _$PlaceDataFromJson(Map<String, dynamic> json) => PlaceData(
      name: json['name'] as String?,
      description: json['description'] as String?,
      city: json['city'] as String?,
      location: json['location'] as String?,
      entryFee: json['entryFee'],
      rating: json['rating'],
      images: json['images'] as String?,
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
      isPopular: json['isPopular'] as bool?,
      category: json['category'] as String?,
      position: json['position'] == null
          ? null
          : Position.fromJson(json['position'] as Map<String, dynamic>),
      distance: json['distance'] as String?,
    );

Map<String, dynamic> _$PlaceDataToJson(PlaceData instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'city': instance.city,
      'location': instance.location,
      'entryFee': instance.entryFee,
      'rating': instance.rating,
      'images': instance.images,
      'openingTime': instance.openingTime,
      'closingTime': instance.closingTime,
      'isPopular': instance.isPopular,
      'category': instance.category,
      'position': instance.position,
      'distance': instance.distance,
    };

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
