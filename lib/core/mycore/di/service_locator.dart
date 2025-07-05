import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../features/nearest_places/data/repos/get_places_repo.dart';
import '../../../features/nearest_places/logic/cubit/get_places_cubit.dart';
import '../../../features/nerest_places_on_map/data/repos/get_nearest_places_repo.dart';
import '../../../features/nerest_places_on_map/logic/get_nearest_places_cubit/get_nearest_places_cubit.dart';
import '../../../features/profile/data/repos/update_user_image_repo.dart';
import '../../../features/profile/data/repos/update_user_repo.dart';
import '../../../features/profile/logic/update_user_cubit/update_user_cubit.dart';
import '../../../features/profile/logic/update_user_image_cubit/update_user_image_cubit.dart';
import '../../../features/settings/data/repos/create_report_repo.dart';
import '../../../features/settings/data/repos/update_pass_repo.dart';
import '../../../features/settings/data/repos/update_report_repo.dart';
import '../../../features/settings/logic/create_report_cubit/create_report_cubit.dart';
import '../../../features/settings/logic/update_pass_cubit/update_pass_cubit.dart';
import '../../../features/settings/logic/update_report_cubit/update_report_cubit.dart';
import '../../../features/sign_in_screen/data/repo/create_new_password_repo.dart';
import '../../../features/sign_in_screen/data/repo/forget_pass_repo.dart';
import '../../../features/sign_in_screen/data/repo/login_repo.dart';
import '../../../features/sign_in_screen/data/repo/verify_password_repo.dart';
import '../../../features/sign_in_screen/logic/create_new_password_cubit/create_new_password_cubit.dart';
import '../../../features/sign_in_screen/logic/forget_pass_cubit/forget_password_cubit.dart';
import '../../../features/sign_in_screen/logic/login_cubit/login_cubit.dart';
import '../../../features/sign_in_screen/logic/verify_pass_cubit/verify_password_cubit.dart';
import '../../../features/sign_up_screen/data/repo/sign_up_repoo.dart';
import '../../../features/sign_up_screen/data/repo/verify_account_repo.dart';
import '../../../features/sign_up_screen/logic/sign_up_cubit/sign_up_cubit.dart';
import '../../../features/sign_up_screen/logic/verify_account_cubit/verify_account_cubit.dart';
import '../logic/user_cubit/user_cubit.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerLazySingleton<UserCubit>(() => UserCubit());
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt(), getIt<UserCubit>()),
  );

  // sign up
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));

  //verify account
  getIt.registerLazySingleton<VerifyAccountRepo>(
    () => VerifyAccountRepo(getIt()),
  );
  getIt.registerFactory<VerifyAccountCubit>(() => VerifyAccountCubit(getIt()));

  // forget password
  getIt.registerLazySingleton<ForgetPassRepo>(
    () => ForgetPassRepo(getIt()),
  );
  getIt
      .registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(getIt()));

  // verify password
  getIt.registerLazySingleton<VerifyPasswordRepo>(
    () => VerifyPasswordRepo(getIt()),
  );
  getIt
      .registerFactory<VerifyPasswordCubit>(() => VerifyPasswordCubit(getIt()));

  //create new password
  getIt.registerLazySingleton<CreateNewPasswordRepo>(
    () => CreateNewPasswordRepo(getIt()),
  );
  getIt.registerFactory<CreateNewPasswordCubit>(
      () => CreateNewPasswordCubit(getIt()));

  //update user
  getIt.registerLazySingleton<UpdateUserRepo>(() => UpdateUserRepo(getIt()));
  getIt.registerFactory<UpdateUserCubit>(() => UpdateUserCubit(getIt()));

  //update user image
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  getIt.registerLazySingleton<UpdateUserImageRepo>(
    () => UpdateUserImageRepo(getIt<Dio>()),
  );

  getIt.registerFactory<UpdateUserImageCubit>(
    () => UpdateUserImageCubit(getIt<UpdateUserImageRepo>()),
  );

  //CreateReport
  getIt.registerLazySingleton<CreateReportRepo>(
    () => CreateReportRepo(getIt()),
  );
  getIt.registerFactory<CreateReportCubit>(() => CreateReportCubit(getIt()));

  //updateReport
  getIt.registerLazySingleton<UpdateReportRepo>(
    () => UpdateReportRepo(getIt()),
  );
  getIt.registerFactory<UpdateReportCubit>(() => UpdateReportCubit(getIt()));

  //update password
  getIt.registerLazySingleton<UpdatePassRepo>(
    () => UpdatePassRepo(getIt()),
  );
  getIt.registerFactory<UpdatePassCubit>(
    () => UpdatePassCubit(getIt()),
  );

  //get places
  getIt.registerLazySingleton<GetPlacesRepo>(
    () => GetPlacesRepo(getIt()),
  );
  getIt.registerFactory<GetPlacesCubit>(
    () => GetPlacesCubit(getIt()),
  );

  //get nearest places
  getIt.registerLazySingleton<GetNearestPlacesRepo>(
    () => GetNearestPlacesRepo(getIt()),
  );
  getIt.registerFactory<GetNearestPlacesCubit>(
    () => GetNearestPlacesCubit(getIt()),
  );
}
