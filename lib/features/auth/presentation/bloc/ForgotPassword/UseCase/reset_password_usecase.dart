import '../../../../domain/repositories.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<void> call({
    required String email,
    required String newPassword,
    required String reNewPassword,
  }) {
    return repository.resetPassword(
      email: email,
      newPassword: newPassword,
      reNewPassword: reNewPassword,
    );
  }
}
