import 'package:json_annotation/json_annotation.dart';
part 'login_response_body.g.dart';

@JsonSerializable()
class LoginResponseBody {
  final UserData data;
  final String token;

  LoginResponseBody({required this.data, required this.token});

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseBodyToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: '_id')
  final String id;
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final bool createReport;
  final String? profileImg;  

  UserData({
    required this.id,
    required this.email,
    required this.role,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.createReport,
    this.profileImg,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
