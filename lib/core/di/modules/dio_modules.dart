// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:online_exam_app_f/core/network/token_interspector.dart'; // افترض إن فيه ملف كده
// import 'package:online_exam_app_f/core/utils/constants/api_endpionts.dart';
// import 'package:online_exam_app_f/features/profile/data/datasources/user_local_storage.dart'; // لجلب الـ token
//
// @module
// abstract class DioModule {
//   @lazySingleton
//   Dio dio() {
//     final dio = Dio(BaseOptions(baseUrl: ApiEndPionts.baseUrl));
//     dio.interceptors.add(TokenInterceptor());
//     return dio;
//   }
// }
//
// class TokenInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     final token = UserLocalStorage.getToken();
//     if (token != null) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     super.onRequest(options, handler);
//   }
// }