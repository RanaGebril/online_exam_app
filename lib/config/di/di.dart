import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:online_exam_app_f/features/auth/data/datasources.dart';
import 'package:online_exam_app_f/features/auth/data/remote/auth_api_client.dart';
import 'package:online_exam_app_f/features/auth/data/repositories.dart';
import 'package:online_exam_app_f/features/auth/domain/usecases.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/UseCase/ForgotPasswordUseCase.dart';
import 'package:online_exam_app_f/features/exam/api/client/exam_api_client.dart';
import 'package:online_exam_app_f/features/exam/data/data_sources/exam_remote_ds.dart';
import 'package:online_exam_app_f/features/exam/domain/repos/exam_repo.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/get_exam_usecase.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/get_questions_usecase.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/get_subjects_usecase.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/search_subjects_usecase.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app_f/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:online_exam_app_f/features/results/data/data_sources/result_local_ds.dart';
import 'package:online_exam_app_f/features/results/presentation/bloc/result_bloc.dart';

import '../../features/exam/api/data_sources_impl/exam_remote_ds_impl.dart';
import '../../features/exam/data/repos_impl/exam_repo_impl.dart';
import '../../features/exam/presentation/bloc/questions/questions_bloc.dart';
import '../../features/results/data/repo/results_repo_impl.dart';
import '../../features/results/domain/repo/results_repo.dart';
import '../../features/results/domain/usecases/get_result_usecase.dart';
import '../../features/results/domain/usecases/save_result_usecase.dart';

final sl = GetIt.instance; // sl = service locator


void setupLocator() {
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // Auth API Client
  sl.registerLazySingleton<AuthApiClient>(
        () => AuthApiClient(sl<Dio>()),
  );

  // Auth Remote Data Source
  sl.registerLazySingleton<AuthRemoteDatasource>(
        () => AuthRemoteDatasource(sl<AuthApiClient>(), sl<Dio>()),
  );

  // Auth Repository
  sl.registerLazySingleton<AuthRepositoryImpl>(
        () => AuthRepositoryImpl(sl<AuthRemoteDatasource>()),
  );

  // Auth UseCases
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

  // ForgotPasswordBloc
  sl.registerFactory<ForgotPasswordBloc>(
        () => ForgotPasswordBloc(sl<ForgotPasswordUseCase>()),
  );

  // Exam API Client
  sl.registerLazySingleton<ExamApiClient>(
        () => ExamApiClient(sl<Dio>()),
  );

  // Exam Remote Data Source
  sl.registerLazySingleton<ExamRemoteDs>(
        () => ExamRemoteDsImpl(sl<ExamApiClient>()),
  );

  // Exam Repository
  sl.registerLazySingleton<ExamRepo>(
        () => ExamRepoImpl(sl<ExamRemoteDs>()),
  );

  // Exam UseCases
  sl.registerLazySingleton<GetSubjectsUsecase>(
        () => GetSubjectsUsecase(sl<ExamRepo>()),
  );

  sl.registerLazySingleton<GetExamUsecase>(
        () => GetExamUsecase(sl<ExamRepo>()),
  );

  sl.registerLazySingleton<GetQuestionsUsecase>(
        () => GetQuestionsUsecase(sl<ExamRepo>()),
  );

  sl.registerLazySingleton<SearchSubjectsUseCase>(
        () => SearchSubjectsUseCase(),
  );

  // Exam Bloc
  sl.registerFactory<ExamBloc>(
        () => ExamBloc(
      sl<GetSubjectsUsecase>(),
      sl<GetExamUsecase>(),
      sl<GetQuestionsUsecase>(),
      sl<SearchSubjectsUseCase>(),
    ),
  );

  // Question Bloc
  sl.registerFactory<QuestionBloc>(() => QuestionBloc(
    sl<GetQuestionsUsecase>()));

//===============================================//
//   result data source
  sl.registerLazySingleton<ResultsLocalDs>(() => ResultsLocalDs());

  // result repo
  sl.registerLazySingleton<ResultsRepo>(() => ResultsRepoImpl(sl<ResultsLocalDs>()));

  // result usecase
  sl.registerLazySingleton<SaveResultUsecase>(() => SaveResultUsecase(sl<ResultsRepo>()));
  sl.registerLazySingleton<GetResultsUsecase>(() => GetResultsUsecase(sl<ResultsRepo>()));

  //result bloc
  sl.registerFactory<ResultBloc>(() => ResultBloc(sl<SaveResultUsecase>(), sl<GetResultsUsecase>()));
  // // result Repository
  // sl.registerLazySingleton<ResultsRepo>(
  //       () => ResultsRepoImpl(sl<Box<ExamResultHiveModel>>()),
  // );
  //
  // // result UseCases
  // sl.registerLazySingleton<SaveResultUsecase>(
  //       () => SaveResultUsecase(sl<ResultsRepo>()),
  // );
  //
  // sl.registerLazySingleton<GetResultsUsecase>(
  //       () => GetResultsUsecase(sl<ResultsRepo>()),
  // );;
  //
  // // Exam Bloc
  // sl.registerFactory<ResultBloc>(
  //       () => ResultBloc(
  //     sl<SaveResultUsecase>(),
  //     sl<GetResultsUsecase>(),
  //   ),
  // );
  //
}