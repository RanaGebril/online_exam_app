import '../domain/repositories.dart';
import 'datasources.dart';
import 'models.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserModel> login(String email, String password) {
    return remote.login(email, password);
  }

  @override
  Future<UserModel> signup({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) {
    return remote.signup(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );
  }

  @override
  Future<void> forgetpassword(String email) {
    return remote.forgetpassword(email);
  }
  @override
  Future<void> verifyResetCode(String code) {
    return remote.verifyResetCode(code);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String reNewPassword}) {
    return remote.resetPassword(
        email: email,
        newPassword: newPassword,
        reNewPassword: reNewPassword
    );
  }
  @override
  Future<void> editProfile({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) {
    return remote.updateUser(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }




}
