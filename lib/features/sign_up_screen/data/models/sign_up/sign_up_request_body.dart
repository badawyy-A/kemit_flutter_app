import 'package:freezed_annotation/freezed_annotation.dart';
part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String passwordConfirm;

  SignupRequestBody({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  });

  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
}
