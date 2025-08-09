// // import 'package:dio/dio.dart';
// // import 'package:hive/hive.dart';
// // import 'package:injectable/injectable.dart';
// //
// // import '../../features/profile/data/datasources/user_local_storage.dart';
// //
// // @lazySingleton
// // class TokenInterceptor extends Interceptor {
// //   @override
// //   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
// //     print("🧪 Interceptor running from TokenInterceptor");
// //
// //     try {
// //
// //       final token =UserLocalStorage.getToken().toString();
// //
// //       if (token.isNotEmpty) {
// //         options.headers['token'] = token;
// //         print("✅ Token from Hive added to header: $token");
// //       } else {
// //         print("⚠️ No token found in Hive");
// //       }
// //     } catch (e) {
// //       print("❌ Error reading token from Hive: $e");
// //     }
// //
// //     return super.onRequest(options, handler); // ✅ مهم!
// //   }
// // }
//
// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
//
// import '../../features/profile/data/datasources/user_local_storage.dart';
// import '../utils/constants/api_endpionts.dart';
//
// @injectable
// @singleton
// class DioClient {
//   final Dio _dio;
//
//   DioClient() : _dio = Dio() {
//     _dio.options.baseUrl = ApiEndPionts.baseUrl;
//     _dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         final token = UserLocalStorage.getToken();
//         if (token != null) {
//           options.headers['token'] = '$token';
//         }
//         return handler.next(options);
//       },
//     ));
//   }
//
//   Dio get dio => _dio;
// }
