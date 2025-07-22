import '../entities/user_profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(UserProfileEntity user) {
    return repository.updateProfile(user);
  }
}
