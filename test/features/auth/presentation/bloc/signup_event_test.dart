import 'package:online_exam_app_f/features/auth/presentation/bloc/signup/signup_event.dart';
import 'package:test/test.dart';

void main() {
  test('SignupButtonPressed props should return correct values', () {
    // Arrange
    final event = SignupButtonPressed(
      username: 'newuser',
      firstName: 'New',
      lastName: 'User',
      email: 'new@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      phone: '987654321',
    );

    // Act & Assert
    expect(event.props, [
      'newuser',
      'New',
      'User',
      'new@example.com',
      'pass123',
      'pass123',
      '987654321',
    ]);
    expect(event.username, 'newuser');
    expect(event.firstName, 'New');
    expect(event.lastName, 'User');
    expect(event.email, 'new@example.com');
    expect(event.password, 'pass123');
    expect(event.rePassword, 'pass123');
    expect(event.phone, '987654321');
  });

  test('Two SignupButtonPressed events with same data should be equal', () {
    // Arrange
    final event1 = SignupButtonPressed(
      username: 'newuser',
      firstName: 'New',
      lastName: 'User',
      email: 'new@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      phone: '987654321',
    );
    final event2 = SignupButtonPressed(
      username: 'newuser',
      firstName: 'New',
      lastName: 'User',
      email: 'new@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      phone: '987654321',
    );

    // Assert
    expect(event1, equals(event2));
  });

  test('Two SignupButtonPressed events with different emails should not be equal', () {
    // Arrange
    final event1 = SignupButtonPressed(
      username: 'newuser',
      firstName: 'New',
      lastName: 'User',
      email: 'new1@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      phone: '987654321',
    );
    final event2 = SignupButtonPressed(
      username: 'newuser',
      firstName: 'New',
      lastName: 'User',
      email: 'new2@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      phone: '987654321',
    );

    // Assert
    expect(event1, isNot(equals(event2)));
  });
}