// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/exam/api/client/exam_api_client.dart' as _i666;
import '../../features/exam/api/data_sources_impl/exam_remote_ds_impl.dart'
    as _i910;
import '../../features/exam/data/data_sources/exam_remote_ds.dart' as _i290;
import '../../features/exam/data/repos_impl/exam_repo_impl.dart' as _i145;
import '../../features/exam/domain/repos/exam_repo.dart' as _i569;
import '../../features/exam/domain/usecases/get_exam_usecase.dart' as _i90;
import '../../features/exam/domain/usecases/get_questions_usecase.dart'
    as _i968;
import '../../features/exam/domain/usecases/get_subjects_usecase.dart' as _i418;
import '../../features/exam/domain/usecases/search_subjects_usecase.dart'
    as _i430;
import '../../features/exam/presentation/bloc/exam_bloc.dart' as _i745;
import '../../features/exam/presentation/bloc/questions/questions_bloc.dart'
    as _i252;
import '../network/token_interspector.dart' as _i215;
import 'modules/dio_modules.dart' as _i288;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.factory<_i430.SearchSubjectsUseCase>(
      () => _i430.SearchSubjectsUseCase(),
    );
    gh.lazySingleton<_i215.TokenInterceptor>(() => _i215.TokenInterceptor());
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dio(gh<_i215.TokenInterceptor>()),
    );
    gh.factory<_i666.ExamApiClient>(() => _i666.ExamApiClient(gh<_i361.Dio>()));
    gh.factory<_i290.ExamRemoteDs>(
      () => _i910.ExamRemoteDsImpl(gh<_i666.ExamApiClient>()),
    );
    gh.factory<_i569.ExamRepo>(
      () => _i145.ExamRepoImpl(gh<_i290.ExamRemoteDs>()),
    );
    gh.factory<_i90.GetExamUsecase>(
      () => _i90.GetExamUsecase(gh<_i569.ExamRepo>()),
    );
    gh.factory<_i968.GetQuestionsUsecase>(
      () => _i968.GetQuestionsUsecase(gh<_i569.ExamRepo>()),
    );
    gh.factory<_i418.GetSubjectsUsecase>(
      () => _i418.GetSubjectsUsecase(gh<_i569.ExamRepo>()),
    );
    gh.factory<_i252.QuestionBloc>(
      () => _i252.QuestionBloc(gh<_i968.GetQuestionsUsecase>()),
    );
    gh.factory<_i745.ExamBloc>(
      () => _i745.ExamBloc(
        gh<_i418.GetSubjectsUsecase>(),
        gh<_i90.GetExamUsecase>(),
        gh<_i968.GetQuestionsUsecase>(),
        gh<_i430.SearchSubjectsUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i288.DioModule {}
