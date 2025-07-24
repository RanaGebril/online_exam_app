import 'package:online_exam_app_f/features/auth/domain/repositories.dart';

import '../data/models.dart';

class LogicUserCase {
  final AuthRepository repo;

  LogicUserCase(this.repo);

  Future<UserModel> call(String email, String password) async {
    return await repo.login(email, password);
  }
}

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<UserModel> call({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    return await repository.signup(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );
  }
}
