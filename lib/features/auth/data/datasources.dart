import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:online_exam_app_f/features/auth/data/remote/auth_api_client.dart';

import '../../../core/utils/constants/api_endpoint.dart';
import 'models.dart';

class AuthRemoteDatasource {
  final AuthApiClient apiClient;
  final Dio client;

  AuthRemoteDatasource(this.apiClient, this.client);
  Future<UserModel> login(String email, String password) {
    return apiClient.login({
      "email": email,
      "password": password,
    });
  }
  Future<UserModel> signup({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    return await apiClient.signup({
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "rePassword": rePassword,
      "phone": phone,
    });
  }
  Future<void> forgotPassword(String email) {
    final body = {"email": email};

    print("🔹 Sending Forgot Password request...");
    print("🔹 URL: ${ApiEndPionts.baseUrl}${ApiEndPionts.forgetpasswordEndPoint}");
    print("🔹 Body: $body");

    return apiClient.forgetpassword(body);
  }

  Future<void> verifyResetCode(String code) async {
    await apiClient.verifyResetCode({"resetCode": code});
  }
  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String reNewPassword,
  }) async {
    await apiClient.resetPassword({
      "email": email,
      "newPassword": newPassword,
      "reNewPassword": reNewPassword,
    });
  }
  Future<void> updateUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    final token = Hive.box('userBox').get('token');
    await apiClient.editProfile(
      {
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
      },
      "Bearer $token",
    );
  }



}

