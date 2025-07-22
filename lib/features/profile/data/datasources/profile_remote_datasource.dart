import '../../domain/entities/user_profile_entity.dart';

abstract class ProfileRemoteDatasource {
  Future<UserProfileEntity> getProfile();
  Future<void> updateProfile(UserProfileEntity user);
}
