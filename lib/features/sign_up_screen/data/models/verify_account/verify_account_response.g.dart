// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAccountResponse _$VerifyAccountResponseFromJson(
        Map<String, dynamic> json) =>
    VerifyAccountResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$VerifyAccountResponseToJson(
        VerifyAccountResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'token': instance.token,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      email: json['Email'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'Email': instance.email,
      'role': instance.role,
    };
