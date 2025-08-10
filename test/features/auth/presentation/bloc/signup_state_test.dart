import 'package:online_exam_app_f/features/auth/presentation/bloc/signup/signup_state.dart';
import 'package:test/test.dart';

void main() {
  test('SignupFailure props should return correct error value', () {
    // Arrange
    const error = 'Invalid data';
    final state = SignupFailure(error);

    // Act & Assert
    expect(state.props, [error]);
    expect(state.error, error);
  });

  test('Two SignupFailure states with same error should be equal', () {
    // Arrange
    const error = 'Invalid data';
    final state1 = SignupFailure(error);
    final state2 = SignupFailure(error);

    // Assert
    expect(state1, equals(state2));
  });

  test('Two SignupFailure states with different errors should not be equal', () {
    // Arrange
    final state1 = SignupFailure('Error 1');
    final state2 = SignupFailure('Error 2');

    // Assert
    expect(state1, isNot(equals(state2)));
  });

  test('SignupInitial, SignupLoading, and SignupSuccess should be equal to themselves', () {
    // Arrange
    final initial = SignupInitial();
    final loading = SignupLoading();
    final success = SignupSuccess();

    // Assert
    expect(initial, equals(SignupInitial()));
    expect(loading, equals(SignupLoading()));
    expect(success, equals(SignupSuccess()));
  });
}