import 'package:dio/dio.dart';
import 'package:morshd/features/settings/data/models/update_password/update_pass_request_body.dart';
import 'package:morshd/features/settings/data/models/update_password/update_pass_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../features/nearest_places/data/models/get_places_response.dart';
import '../../../features/nerest_places_on_map/data/models/get_nearest_places_response.dart';
import '../../../features/profile/data/models/update_user_request_body.dart';
import '../../../features/profile/data/models/update_user_response.dart';
import '../../../features/settings/data/models/create_report/create_report_request_body.dart';
import '../../../features/settings/data/models/create_report/create_report_response.dart';
import '../../../features/settings/data/models/update_report/update_report_request_body.dart';
import '../../../features/settings/data/models/update_report/update_report_response.dart';
import '../../../features/sign_in_screen/data/models/create_new_password/create_new_password_request_body.dart';
import '../../../features/sign_in_screen/data/models/create_new_password/create_new_password_response.dart';
import '../../../features/sign_in_screen/data/models/forget_password/forget_pass_email_request_body.dart';
import '../../../features/sign_in_screen/data/models/forget_password/forget_pass_response.dart';
import '../../../features/sign_in_screen/data/models/login/login_request_body.dart';
import '../../../features/sign_in_screen/data/models/login/login_response_body.dart';
import '../../../features/sign_in_screen/data/models/verify_password/verify_password_request_body.dart';
import '../../../features/sign_in_screen/data/models/verify_password/verify_password_response.dart';
import '../../../features/sign_up_screen/data/models/sign_up/sign_up_request_body.dart';
import '../../../features/sign_up_screen/data/models/sign_up/sign_up_response.dart';
import '../../../features/sign_up_screen/data/models/verify_account/verify_account_request_body.dart';
import '../../../features/sign_up_screen/data/models/verify_account/verify_account_response.dart';
import 'api_constants.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  @POST(ApiConstants.login)
  Future<LoginResponseBody> login(@Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.signUp)
  Future<SignupResponse> signUp(@Body() SignupRequestBody signupRequestBody);

  @POST(ApiConstants.verifyAccount)
  Future<VerifyAccountResponse> verifyAccount(
    @Body() VerifyAccountRequestBody verifyAccountRequestBody,
    @Header('Authorization') String token,
  );

  @POST(ApiConstants.forgetPassword)
  Future<ForgetPassResponse> forgetPassword(
    @Body() ForgetPassEmailRequestBody forgetPassEmailRequestBody,
  );

  @POST(ApiConstants.verifyPassword)
  Future<VerifyPasswordResponse> verifyPassword(
    @Body() VerifyPasswordRequestBody verifyPasswordRequestBody,
    @Header('Authorization') String token,
  );

  @PUT(ApiConstants.resetPassword)
  Future<CreateNewPasswordResponse> createNewPassword(
    @Header('Authorization') String token,
    @Body() CreateNewPasswordRequestBody createNewPasswordRequestBody,
  );

  @PUT(ApiConstants.updateUser)
  Future<UpdateUserResponse> updateUser(
    @Header('Authorization') String token,
    @Body() UpdateUserRequestBody updateUserRequestBody,
  );

  @POST(ApiConstants.createReport)
  Future<CreateReportResponse> createReport(
    @Header('Authorization') String token,
    @Body() CreateReportRequestBody createReportRequestBody,
  );

  @PUT(ApiConstants.updateReport)
  Future<UpdateReportResponse> updateReport(
    @Header('Authorization') String token,
    @Path('id') String id,
    @Body() UpdateReportRequestBody updateReportRequestBody,
  );

  @PUT(ApiConstants.updatePassword)
  Future<UpdatePassResponse> updatePassword(
    @Header('Authorization') String token,
    @Body() UpdatePassRequestBody updatePassRequestBody,
  );

  @GET(ApiConstants.getPlaces)
  Future<GetPlacesResponse> getAllPlaces(
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.getNerestPlaces)
  Future<GetNearestPlacesResponse> getNearestPlaces(
    @Header('Authorization') String token,
     @Query('lng') double lng,
    @Query('lat') double lat,
   
  );
}
