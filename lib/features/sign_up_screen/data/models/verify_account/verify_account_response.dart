import 'package:freezed_annotation/freezed_annotation.dart';
part 'verify_account_response.g.dart';
@JsonSerializable()
class VerifyAccountResponse {
  String? status;
  UserData? data;
  String? token;

  VerifyAccountResponse({this.status, this.data, this.token});

  factory VerifyAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyAccountResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: '_id')
  String? id;
  String? fullName;
  String? phone;
  @JsonKey(name: 'Email')
  String? email;
  String? role;

  UserData({this.id, this.fullName, this.phone, this.email, this.role});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
