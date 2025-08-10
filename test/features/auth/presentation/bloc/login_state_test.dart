import 'package:online_exam_app_f/features/auth/presentation/bloc/login/login_state.dart';
import 'package:test/test.dart';

void main() {
  test('LoginFailure props should return correct error value', () {
    // Arrange
    const error = 'Invalid credentials';
    final state = LoginFailure(error);

    // Act & Assert
    expect(state.props, [error]);
    expect(state.error, error);
  });

  test('Two LoginFailure states with same error should be equal', () {
    // Arrange
    const error = 'Invalid credentials';
    final state1 = LoginFailure(error);
    final state2 = LoginFailure(error);

    // Assert
    expect(state1, equals(state2));
  });

  test('Two LoginFailure states with different errors should not be equal', () {
    // Arrange
    final state1 = LoginFailure('Error 1');
    final state2 = LoginFailure('Error 2');

    // Assert
    expect(state1, isNot(equals(state2)));
  });

  test('LoginInitial, LoginLoading, and LoginSuccess should be equal to themselves', () {
    // Arrange
    final initial = LoginInitial();
    final loading = LoginLoading();
    final success = LoginSuccess();

    // Assert
    expect(initial, equals(LoginInitial()));
    expect(loading, equals(LoginLoading()));
    expect(success, equals(LoginSuccess()));
  });
}