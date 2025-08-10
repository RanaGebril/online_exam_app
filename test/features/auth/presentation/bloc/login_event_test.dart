import 'package:online_exam_app_f/features/auth/presentation/bloc/login/login_event.dart';
import 'package:test/test.dart';

void main() {
  test('LoginButtonPressed props should return correct values', () {
    // Arrange
    const email = 'test@example.com';
    const password = 'password123';
    final event = LoginButtonPressed(email, password);

    // Act & Assert
    expect(event.props, [email, password]);
    expect(event.email, email);
    expect(event.password, password);
  });

  test('Two LoginButtonPressed events with same email and password should be equal', () {
    // Arrange
    const email = 'test@example.com';
    const password = 'password123';
    final event1 = LoginButtonPressed(email, password);
    final event2 = LoginButtonPressed(email, password);

    // Assert
    expect(event1, equals(event2));
  });

  test('Two LoginButtonPressed events with different passwords should not be equal', () {
    // Arrange
    final event1 = LoginButtonPressed('test@example.com', 'pass1');
    final event2 = LoginButtonPressed('test@example.com', 'pass2');

    // Assert
    expect(event1, isNot(equals(event2)));
  });
}