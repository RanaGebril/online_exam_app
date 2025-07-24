import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:online_exam_app_f/features/auth/data/remote/auth_api_client.dart';

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
  Future<void> forgetpassword(String email) async {
    await apiClient.forgetpassword({"email": email});
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

