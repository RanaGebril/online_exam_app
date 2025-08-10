import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/UseCase/ForgotPasswordUseCase.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/forgot_password_event.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/forgot_password_state.dart';
import 'package:test/test.dart';

class MockForgotPasswordUseCase extends Mock implements ForgotPasswordUseCase {}

void main() {
  late ForgotPasswordBloc bloc;
  late MockForgotPasswordUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockForgotPasswordUseCase();
    bloc = ForgotPasswordBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  blocTest<ForgotPasswordBloc, ForgotPasswordState>(
    'emits [ForgotLoading, ForgotSuccess] when SendForgotPasswordEmail is successful',
    build: () {
      when(() => mockUseCase('test@example.com')).thenAnswer((_) async {});
      return bloc;
    },
    act: (bloc) => bloc.add(SendForgotPasswordEmail('test@example.com')),
    expect: () => [ForgotLoading(), ForgotSuccess()],
  );

  blocTest<ForgotPasswordBloc, ForgotPasswordState>(
    'emits [ForgotLoading, ForgotFailure] when SendForgotPasswordEmail fails',
    build: () {
      when(() => mockUseCase('test@example.com')).thenThrow(Exception('Error'));
      return bloc;
    },
    act: (bloc) => bloc.add(SendForgotPasswordEmail('test@example.com')),
    expect: () => [ForgotLoading(), ForgotFailure('Exception: Error')],
  );
}