import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:online_exam_app_f/features/auth/domain/repositories.dart';
import 'package:online_exam_app_f/features/auth/domain/usecases.dart';
import 'package:online_exam_app_f/features/auth/data/models.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LogicUserCase loginUseCase;
  late SignupUseCase signupUseCase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    loginUseCase = LogicUserCase(mockRepo);
    signupUseCase = SignupUseCase(mockRepo);
  });

  test('login should return UserModel from repository', () async {
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
    when(() => mockRepo.login(email, password)).thenAnswer((_) async => mockUser);

    // Act
    final result = await loginUseCase(email, password);

    // Assert
    expect(result.id, mockUser.id);
    expect(result.token, mockUser.token);
    verify(() => mockRepo.login(email, password)).called(1);
  });

  test('signup should return UserModel from repository', () async {
    // Arrange
     var mockUser = UserModel(
      id: '2',
      username: 'newuser',
      email: 'new@example.com',
      name: 'New User',
      phone: '987654321',
      token: 'xyz789',
      firstName: 'New',
      lastName: 'User',
    );
    when(() => mockRepo.signup(
      username: 'newuser',
      firstName: 'New',
      lastName: 'User',
      email: 'new@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      phone: '987654321',
    )).thenAnswer((_) async => mockUser);

    // Act
    final result = await signupUseCase(
      username: 'newuser',
      firstName: 'New',
      lastName: 'User',
      email: 'new@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      phone: '987654321',
    );

    // Assert
    expect(result.id, mockUser.id);
    expect(result.token, mockUser.token);
    verify(() => mockRepo.signup(
      username: 'newuser',
      firstName: 'New',
      lastName: 'User',
      email: 'new@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      phone: '987654321',
    )).called(1);
  });
}