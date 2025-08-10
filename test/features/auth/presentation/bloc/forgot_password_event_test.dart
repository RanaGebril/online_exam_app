import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/forgot_password_event.dart';
import 'package:test/test.dart';

void main() {
  test('SendForgotPasswordEmail props should return correct values', () {
    // Arrange
    const email = 'test@example.com';
    final event = SendForgotPasswordEmail(email);

    // Act & Assert
    expect(event.props, [email]);
    expect(event.email, email);
  });

  test('Two SendForgotPasswordEmail events with same email should be equal', () {
    // Arrange
    const email = 'test@example.com';
    final event1 = SendForgotPasswordEmail(email);
    final event2 = SendForgotPasswordEmail(email);

    // Assert
    expect(event1, equals(event2));
  });

  test('Two SendForgotPasswordEmail events with different emails should not be equal', () {
    // Arrange
    final event1 = SendForgotPasswordEmail('test1@example.com');
    final event2 = SendForgotPasswordEmail('test2@example.com');

    // Assert
    expect(event1, isNot(equals(event2)));
  });
}