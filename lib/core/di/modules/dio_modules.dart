import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/core/network/token_interspector.dart';
import 'package:online_exam_app_f/core/utils/constants/api_endpionts.dart';


@module
abstract class DioModule {
  @lazySingleton
  Dio dio(TokenInterceptor interceptors ) {
    final dio = Dio(BaseOptions(baseUrl: ApiEndPionts.baseUrl));
    dio.interceptors.add(interceptors);
    return dio;
  }
}

