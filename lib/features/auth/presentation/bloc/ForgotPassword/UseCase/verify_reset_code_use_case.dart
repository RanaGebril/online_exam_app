import '../../../../domain/repositories.dart';

class VerifyResetCodeUseCase {
  final AuthRepository repository;

  VerifyResetCodeUseCase(this.repository);

  Future<void> call(String code) {
    return repository.verifyResetCode(code);
  }
}
