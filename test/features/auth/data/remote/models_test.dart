import 'package:online_exam_app_f/features/auth/data/models.dart';
import 'package:test/test.dart';

void main() {
  test('UserModel should convert to and from JSON correctly', () {
    // Arrange
    final json = {
      'user': {
        'id': '1',
        'username': 'testuser',
        'email': 'test@example.com',
        'firstName': 'Test',
        'lastName': 'User',
        'phone': '123456789',
      },
      'token': 'abc123',
    };
    final expectedModel = UserModel(
      id: '1',
      username: 'testuser',
      email: 'test@example.com',
      name: 'Test User',
      phone: '123456789',
      token: 'abc123',
      firstName: 'Test',
      lastName: 'User',
    );

    // Act
    final model = UserModel.fromJson(json);
    final toJson = model.toJson();

    // Assert
    expect(model.id, expectedModel.id);
    expect(model.username, expectedModel.username);
    expect(model.email, expectedModel.email);
    expect(model.name, expectedModel.name);
    expect(model.phone, expectedModel.phone);
    expect(model.token, expectedModel.token);
    expect(model.firstName, expectedModel.firstName);
    expect(model.lastName, expectedModel.lastName);
    expect(toJson, {
      'id': '1',
      'username': 'testuser',
      'email': 'test@example.com',
      'name': 'Test User',
      'firstName': 'Test',
      'lastName': 'User',
      'phone': '123456789',
      'token': 'abc123',
    });
  });
}