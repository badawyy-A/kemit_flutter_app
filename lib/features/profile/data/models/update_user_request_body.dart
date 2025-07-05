import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_user_request_body.g.dart';

@JsonSerializable()
class UpdateUserRequestBody {
  final String? firstName;
  final String? lastName;
  final String? userName;

  UpdateUserRequestBody({
    this.firstName,
    this.lastName,
    this.userName,
  });

  Map<String, dynamic> toJson() => _$UpdateUserRequestBodyToJson(this);
}
