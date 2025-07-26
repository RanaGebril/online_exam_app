import '../../../../domain/repositories.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<void> call(String email) {
    return repository.forgetpassword(email);
  }
}
