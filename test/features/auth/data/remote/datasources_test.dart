import 'package:mocktail/mocktail.dart';
import 'package:online_exam_app_f/features/auth/data/datasources.dart';
import 'package:online_exam_app_f/features/auth/data/models.dart';
import 'package:test/test.dart';
import 'package:online_exam_app_f/features/auth/data/remote/auth_api_client.dart';
import 'package:dio/dio.dart';

class MockAuthApiClient extends Mock implements AuthApiClient {}
class MockDio extends Mock implements Dio {}

void main() {
  late AuthRemoteDatasource datasource;
  late MockAuthApiClient mockApiClient;
  late MockDio mockDio;

  setUp(() {
    mockApiClient = MockAuthApiClient();
    mockDio = MockDio();
    datasource = AuthRemoteDatasource(mockApiClient, mockDio);
  });

  test('login should return UserModel from apiClient', () async {
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
    when(() => mockApiClient.login({'email': email, 'password': password}))
        .thenAnswer((_) async => mockUser);

    // Act
    final result = await datasource.login(email, password);

    // Assert
    expect(result.id, mockUser.id);
    expect(result.token, mockUser.token);
    verify(() => mockApiClient.login({'email': email, 'password': password})).called(1);
  });
}