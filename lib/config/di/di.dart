import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/datasources.dart';
import '../../features/auth/data/remote/auth_api_client.dart';
import '../../features/auth/data/repositories.dart';
import '../../features/auth/domain/usecases.dart';
import '../../features/auth/presentation/bloc/ForgotPassword/UseCase/ForgotPasswordUseCase.dart';
import '../../features/profile/domain/usecases/update_profile_usecase.dart';

final sl = GetIt.instance; // sl = service locator

void setupLocator() {
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // API Client
  sl.registerLazySingleton<AuthApiClient>(
        () => AuthApiClient(sl<Dio>()),
  );


  // Remote Data Source
  sl.registerLazySingleton<AuthRemoteDatasource>(
        () => AuthRemoteDatasource(sl<AuthApiClient>(), sl<Dio>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepositoryImpl>(
        () => AuthRepositoryImpl(sl<AuthRemoteDatasource>()),
  );

  // UseCases
  sl.registerLazySingleton<LogicUserCase>(
        () => LogicUserCase(sl<AuthRepositoryImpl>()),
  );

  sl.registerLazySingleton<SignupUseCase>(
        () => SignupUseCase(sl<AuthRepositoryImpl>()),
  );

  sl.registerLazySingleton<UpdateUserUseCase>(
        () => UpdateUserUseCase(sl<AuthRepositoryImpl>()),
  );

  sl.registerLazySingleton<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(sl<AuthRepositoryImpl>()),
  );
}
