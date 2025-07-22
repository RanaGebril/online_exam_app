import '../data/models.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  });
  Future<void> forgetpassword(String email);
  Future<void> verifyResetCode(String code);
  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String reNewPassword,
  });
}
