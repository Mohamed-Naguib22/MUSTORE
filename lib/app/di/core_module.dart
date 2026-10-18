import 'package:get_it/get_it.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';
import 'package:mustore/core/network/interceptors/auth_interceptor.dart';
import 'package:mustore/core/services/encryption/encryption_service.dart';
import 'package:mustore/core/services/encryption/otp_encryption_service.dart';
import 'package:mustore/core/services/encryption/password_encryption_service.dart';
import 'package:mustore/core/storage/local_storage.dart';
import 'package:mustore/core/storage/secure_storage.dart';
import 'package:mustore/features/auth/data/constants/auth_endpoints.dart';
import 'package:mustore/features/auth/domain/events/session_event.dart';
import 'package:mustore/infrastructure/network/dio_api_client.dart';
import 'package:mustore/infrastructure/network/network_connection_impl.dart';
import 'package:mustore/infrastructure/services/encryption/otp_encryption_service_impl.dart';
import 'package:mustore/infrastructure/services/encryption/password_encryption_service_impl.dart';
import 'package:mustore/infrastructure/services/encryption/rsa_encryption_service.dart';
import 'package:mustore/infrastructure/storage/preferences_storage_impl.dart';
import 'package:mustore/infrastructure/storage/secure_storage_impl.dart';

Future<void> registerCoreModule(GetIt sl) async {
  sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl());
  sl.registerLazySingleton<LocalStorage>(() => PreferencesStorageImpl());

  sl.registerLazySingleton<SessionEvents>(() => SessionEvents(),
    dispose: (e) => e.dispose(),
  );

  sl.registerLazySingleton<EncryptionService>(() => RsaEncryptionService(),
    instanceName: 'rsa',
  );

  sl.registerLazySingleton<PasswordEncryptionService>(
        () => PasswordEncryptionServiceImpl(
      rsaEncryptionService: sl<EncryptionService>(instanceName: 'rsa'),
    ),
  );

  sl.registerLazySingleton<OtpEncryptionService>(
        () => OtpEncryptionServiceImpl(
      rsaEncryptionService: sl<EncryptionService>(instanceName: 'rsa'),
    ),
  );

  sl.registerLazySingleton<NetworkConnection>(() => NetworkConnectionImpl());

  sl.registerLazySingleton<ApiClient>(
        () => DioApiClient(interceptors: [
      AuthInterceptor(
        tokenStorage: sl(),
        sessionEvents: sl(),
        refreshPath: AuthEndpoints.refreshToken,
        revokePath: AuthEndpoints.revokeSession,
        publicPaths: {
          AuthEndpoints.register,
          AuthEndpoints.verifyEmail,
          AuthEndpoints.resendOtp,
          AuthEndpoints.login,
          AuthEndpoints.externalLogin,
          AuthEndpoints.refreshToken,
          AuthEndpoints.revokeSession,
          AuthEndpoints.forgetPassword,
          AuthEndpoints.resetPassword,
        },
      ),
    ]),
    dispose: (client) => (client as DioApiClient).dispose(),
  );
}