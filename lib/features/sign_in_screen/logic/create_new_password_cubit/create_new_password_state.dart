import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/mycore/networking/api_error_model.dart';
part 'create_new_password_state.freezed.dart';
@freezed
class CreateNewPasswordState<T> with _$CreateNewPasswordState<T> {
  const factory CreateNewPasswordState.initial() = _Initial;
   const factory CreateNewPasswordState.loading() = Loading;
  const factory CreateNewPasswordState.success(T data) = Success;
  const factory CreateNewPasswordState.error(ApiErrorModel apiErrorModel) =
      Error;
}
