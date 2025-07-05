import 'package:freezed_annotation/freezed_annotation.dart';
part 'verify_password_response.g.dart';

@JsonSerializable()
class VerifyPasswordResponse {
  String? status;
  String? token;

  VerifyPasswordResponse({this.status, this.token});

  factory VerifyPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyPasswordResponseFromJson(json);
}
