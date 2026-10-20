import 'package:get_it/get_it.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/core/services/auth/external_auth_service.dart';
import 'package:mustore/core/services/encryption/otp_encryption_service.dart';
import 'package:mustore/core/services/encryption/password_encryption_service.dart';
import 'package:mustore/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:mustore/features/auth/data/data_sources/remote/auth_remote_data_source_impl.dart';
import 'package:mustore/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mustore/features/auth/domain/repositories/auth_repository.dart';
import 'package:mustore/features/auth/domain/use_cases/change_password_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/external_login_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/login_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/refresh_token_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/register_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/resend_otp_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/revoke_session_use_case.dart';
import 'package:mustore/features/auth/domain/use_cases/verify_email_use_case.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/data/data_sources/local/session_storage.dart';
import 'package:mustore/features/auth/data/data_sources/local/session_storage_impl.dart';

void registerAuthModule(GetIt sl) {
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );

  sl.registerLazySingleton<SessionStorage>(() => SessionStorageImpl(sl()));

  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      networkConnection: sl(),
      remoteDataSource: sl(),
      sessionStorage: sl(),
    ),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => ResendOtpUseCase(sl()));
  sl.registerLazySingleton(() => ExternalLoginUseCase(sl()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));
  sl.registerLazySingleton(() => RevokeSessionUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));

  sl.registerLazySingleton(() => AuthCubit(
    login: sl(),
    register: sl(),
    verifyEmail: sl(),
    resendOtp: sl(),
    externalLogin: sl(),
    refreshToken: sl(),
    revokeSession: sl(),
    forgetPassword: sl(),
    resetPassword: sl(),
    changePassword: sl(),
    sessionStorage: sl(),
    sessionEvents: sl(),
    passwordEncryption: sl<PasswordEncryptionService>(),
    otpEncryptionService: sl<OtpEncryptionService>(),
    externalAuthService: sl<ExternalAuthService>(),
  ));
}