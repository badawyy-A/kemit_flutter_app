import 'package:json_annotation/json_annotation.dart';

part 'get_nearest_places_response.g.dart';

@JsonSerializable()
class GetNearestPlacesResponse {
  List<PlaceData>? data;

  GetNearestPlacesResponse({this.data});

  factory GetNearestPlacesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetNearestPlacesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetNearestPlacesResponseToJson(this);
}

@JsonSerializable()
class PlaceData {
  String? name;
  String? description;
  String? city;
  String? location;
  dynamic entryFee;
  dynamic rating;
  String? images;
  dynamic openingTime;
  dynamic closingTime;
  bool? isPopular;
  String? category;
  Position? position;
  String? distance;

  PlaceData({
    this.name,
    this.description,
    this.city,
    this.location,
    this.entryFee,
    this.rating,
    this.images,
    this.openingTime,
    this.closingTime,
    this.isPopular,
    this.category,
    this.position,
    this.distance,
  });

  factory PlaceData.fromJson(Map<String, dynamic> json) =>
      _$PlaceDataFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDataToJson(this);
}

@JsonSerializable()
class Position {
  String? lat;
  String? lng;

  Position({this.lat, this.lng});

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
