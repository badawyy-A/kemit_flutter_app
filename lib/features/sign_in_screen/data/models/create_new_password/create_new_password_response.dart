import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_new_password_response.g.dart';

@JsonSerializable()
class CreateNewPasswordResponse {
  String? token;

  CreateNewPasswordResponse({
    this.token,
  });

  factory CreateNewPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateNewPasswordResponseFromJson(json);
}
