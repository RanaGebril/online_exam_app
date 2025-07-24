import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<UserProfileEntity> getProfile() => remote.getProfile();

  @override
  Future<void> updateProfile(UserProfileEntity user) => remote.updateProfile(user);
}
