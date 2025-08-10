import 'package:test/test.dart';
import 'package:online_exam_app_f/features/auth/domain/entities.dart';

void main() {
  test('UserEntity should create an instance with correct values', () {
    // Arrange
    const id = '1';
    const email = 'test@example.com';
    const name = 'Test User';
    const username = 'testuser';
    const phone = '123456789';
    const firstName = 'Test';
    const lastName = 'User';
    const token = 'abc123';

    // Act
    final user = UserEntity(
      id: id,
      name: name,
      email: email,
      username: username,
      phone: phone,
      firstName: firstName,
      lastName: lastName,
      token: token,
    );

    // Assert
    expect(user.id, id);
    expect(user.email, email);
    expect(user.name, name);
    expect(user.username, username);
    expect(user.phone, phone);
    expect(user.firstName, firstName);
    expect(user.lastName, lastName);
    expect(user.token, token);
  });
}