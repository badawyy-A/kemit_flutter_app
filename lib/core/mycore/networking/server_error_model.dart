import 'package:freezed_annotation/freezed_annotation.dart';
part 'server_error_model.g.dart';

@JsonSerializable()
class ServerErrorModel {
  final List<ServerErrorDetail>? errors;

  ServerErrorModel({required this.errors});

  factory ServerErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ServerErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServerErrorModelToJson(this);
}

@JsonSerializable()
class ServerErrorDetail {
  final String? type;
  final String? value;
  final String? msg;
  final String? path;
  final String? location;

  ServerErrorDetail({
    required this.type,
    required this.value,
    required this.msg,
    required this.path,
    required this.location,
  });

  factory ServerErrorDetail.fromJson(Map<String, dynamic> json) =>
      _$ServerErrorDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ServerErrorDetailToJson(this);
}
