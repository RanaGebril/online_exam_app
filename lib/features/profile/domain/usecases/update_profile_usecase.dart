import '../../../auth/domain/repositories.dart';

class UpdateUserUseCase {
  final AuthRepository repo;

  UpdateUserUseCase(this.repo);

  Future<void> call({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    await repo.editProfile(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }
}
