// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRequestBody _$UpdateUserRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateUserRequestBody(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$UpdateUserRequestBodyToJson(
        UpdateUserRequestBody instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
    };
