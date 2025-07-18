import 'package:json_annotation/json_annotation.dart';
part 'update_user_image_response.g.dart';

@JsonSerializable()
class UpdateUserImageResponse {
  final UserData data;

  UpdateUserImageResponse({required this.data});

  factory UpdateUserImageResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserImageResponseToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String role;
  final bool createReport;
  final String? profileImg;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.role,
    required this.createReport,
    this.profileImg,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
