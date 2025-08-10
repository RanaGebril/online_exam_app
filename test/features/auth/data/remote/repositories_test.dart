import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:online_exam_app_f/features/auth/data/datasources.dart';
import 'package:online_exam_app_f/features/auth/data/repositories.dart';
import 'package:online_exam_app_f/features/auth/data/models.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDatasource mockRemote;

  setUp(() {
    mockRemote = MockAuthRemoteDatasource();
    repository = AuthRepositoryImpl(mockRemote);
  });

  test('login should return UserModel from remote datasource', () async {
    // Arrange
    const email = 'test@example.com';
    const password = 'password123';
     var mockUser = UserModel(
      id: '1',
      username: 'testuser',
      email: email,
      name: 'Test User',
      phone: '123456789',
      token: 'abc123',
      firstName: 'Test',
      lastName: 'User',
    );
    when(() => mockRemote.login(email, password)).thenAnswer((_) async => mockUser);

    // Act
    final result = await repository.login(email, password);

    // Assert
    expect(result.id, mockUser.id);
    expect(result.token, mockUser.token);
    verify(() => mockRemote.login(email, password)).called(1);
  });
}