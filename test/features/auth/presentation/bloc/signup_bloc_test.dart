import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:online_exam_app_f/features/auth/data/models.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/signup/signup_event.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/signup/signup_state.dart';
import 'package:test/test.dart';
import 'package:online_exam_app_f/features/auth/domain/usecases.dart';

class MockSignupUseCase extends Mock implements SignupUseCase {}

void main() {
  late SignupBloc bloc;
  late MockSignupUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockSignupUseCase();
    bloc = SignupBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  blocTest<SignupBloc, SignupState>(
    'emits [SignupLoading, SignupSuccess] when signup is successful',
    build: () {
      when(() => mockUseCase(
        username: 'newuser',
        firstName: 'New',
        lastName: 'User',
        email: 'new@example.com',
        password: 'pass123',
        rePassword: 'pass123',
        phone: '987654321',
      )).thenAnswer((_) async => UserModel(
        id: '2',
        username: 'newuser',
        email: 'new@example.com',
        name: 'New User',
        phone: '987654321',
        token: 'xyz789',
        firstName: 'New',
        lastName: 'User',
      ));
      return bloc;
    },
    act: (bloc) => bloc.add(SignupButtonPressed(
      username: 'newuser',
      firstName: 'New',
      lastName: 'User',
      email: 'new@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      phone: '987654321',
    )),
    expect: () => [SignupLoading(), SignupSuccess()],
  );

  blocTest<SignupBloc, SignupState>(
    'emits [SignupLoading, SignupFailure] when signup fails with DioError',
    build: () {
      when(() => mockUseCase(
        username: 'newuser',
        firstName: 'New',
        lastName: 'User',
        email: 'new@example.com',
        password: 'pass123',
        rePassword: 'pass123',
        phone: '987654321',
      )).thenThrow(DioError(requestOptions: RequestOptions(path: '')));
      return bloc;
    },
    act: (bloc) => bloc.add(SignupButtonPressed(
      username: 'newuser',
      firstName: 'New',
      lastName: 'User',
      email: 'new@example.com',
      password: 'pass123',
      rePassword: 'pass123',
      phone: '987654321',
    )),
    expect: () => [SignupLoading(), SignupFailure('')],
  );
}