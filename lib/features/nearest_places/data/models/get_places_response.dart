import 'package:json_annotation/json_annotation.dart';
part 'get_places_response.g.dart';

@JsonSerializable()
class GetPlacesResponse {
  final List<PlaceModel> data;

  GetPlacesResponse({required this.data});

  factory GetPlacesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPlacesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPlacesResponseToJson(this);
}

@JsonSerializable()
class PlaceModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;
  final String city;
  final String location;
  final int entryFee;
  final double rating;
  final DateTime openingTime;
  final DateTime closingTime;
  final bool isPopular;
  final String category;
  @JsonKey(name: '__v')
  final int v;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String images;

  PlaceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.location,
    required this.entryFee,
    required this.rating,
    required this.openingTime,
    required this.closingTime,
    required this.isPopular,
    required this.category,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
