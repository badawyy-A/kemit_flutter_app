// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_places_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPlacesResponse _$GetPlacesResponseFromJson(Map<String, dynamic> json) =>
    GetPlacesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPlacesResponseToJson(GetPlacesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => PlaceModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      location: json['location'] as String,
      entryFee: (json['entryFee'] as num).toInt(),
      rating: (json['rating'] as num).toDouble(),
      openingTime: DateTime.parse(json['openingTime'] as String),
      closingTime: DateTime.parse(json['closingTime'] as String),
      isPopular: json['isPopular'] as bool,
      category: json['category'] as String,
      v: (json['__v'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      images: json['images'] as String,
    );

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'city': instance.city,
      'location': instance.location,
      'entryFee': instance.entryFee,
      'rating': instance.rating,
      'openingTime': instance.openingTime.toIso8601String(),
      'closingTime': instance.closingTime.toIso8601String(),
      'isPopular': instance.isPopular,
      'category': instance.category,
      '__v': instance.v,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'images': instance.images,
    };
