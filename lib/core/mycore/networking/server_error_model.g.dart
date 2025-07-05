// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerErrorModel _$ServerErrorModelFromJson(Map<String, dynamic> json) =>
    ServerErrorModel(
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ServerErrorDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServerErrorModelToJson(ServerErrorModel instance) =>
    <String, dynamic>{
      'errors': instance.errors,
    };

ServerErrorDetail _$ServerErrorDetailFromJson(Map<String, dynamic> json) =>
    ServerErrorDetail(
      type: json['type'] as String?,
      value: json['value'] as String?,
      msg: json['msg'] as String?,
      path: json['path'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$ServerErrorDetailToJson(ServerErrorDetail instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'msg': instance.msg,
      'path': instance.path,
      'location': instance.location,
    };
