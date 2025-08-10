import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/forgot_password_state.dart';
import 'package:test/test.dart';

void main() {
  test('ForgotFailure props should return correct message value', () {
    // Arrange
    const message = 'Email not found';
    final state = ForgotFailure(message);

    // Act & Assert
    expect(state.props, [message]);
    expect(state.message, message);
  });

  test('Two ForgotFailure states with same message should be equal', () {
    // Arrange
    const message = 'Email not found';
    final state1 = ForgotFailure(message);
    final state2 = ForgotFailure(message);

    // Assert
    expect(state1, equals(state2));
  });

  test('Two ForgotFailure states with different messages should not be equal', () {
    // Arrange
    final state1 = ForgotFailure('Error 1');
    final state2 = ForgotFailure('Error 2');

    // Assert
    expect(state1, isNot(equals(state2)));
  });

  test('ForgotInitial, ForgotLoading, and ForgotSuccess should be equal to themselves', () {
    // Arrange
    final initial = ForgotInitial();
    final loading = ForgotLoading();
    final success = ForgotSuccess();

    // Assert
    expect(initial, equals(ForgotInitial()));
    expect(loading, equals(ForgotLoading()));
    expect(success, equals(ForgotSuccess()));
  });
}