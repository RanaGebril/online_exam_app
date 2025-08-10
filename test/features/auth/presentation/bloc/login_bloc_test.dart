import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:online_exam_app_f/features/auth/data/models.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/login/login_event.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/login/login_state.dart';
import 'package:online_exam_app_f/features/profile/data/datasources/user_local_storage.dart';
import 'package:test/test.dart';
import 'package:online_exam_app_f/features/auth/domain/usecases.dart';


class MockLogicUserCase extends Mock implements LogicUserCase {}
class MockSaveUserUseCase extends Mock implements SaveUserUseCase {}

void main() {
  late LoginBloc bloc;
  late MockLogicUserCase mockLoginUseCase;
  late MockSaveUserUseCase mockSaveUserUseCase;

  setUp(() {
    mockLoginUseCase = MockLogicUserCase();
    mockSaveUserUseCase = MockSaveUserUseCase();
    bloc = LoginBloc(mockLoginUseCase, mockSaveUserUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  blocTest<LoginBloc, LoginState>(
    'emits [LoginLoading, LoginSuccess] when login is successful',
    build: () {
      when(() => mockLoginUseCase('test@example.com', 'password123'))
          .thenAnswer((_) async => UserModel(
        id: '1',
        username: 'testuser',
        email: 'test@example.com',
        name: 'Test User',
        phone: '123456789',
        token: 'abc123',
        firstName: 'Test',
        lastName: 'User',
      ));
      when(() => mockSaveUserUseCase(any())).thenAnswer((_) async {});
      return bloc;
    },
    act: (bloc) => bloc.add(LoginButtonPressed('test@example.com', 'password123')),
    expect: () => [LoginLoading(), LoginSuccess()],
  );

  blocTest<LoginBloc, LoginState>(
    'emits [LoginLoading, LoginFailure] when login fails',
    build: () {
      when(() => mockLoginUseCase('test@example.com', 'password123'))
          .thenThrow(Exception('Error'));
      return bloc;
    },
    act: (bloc) => bloc.add(LoginButtonPressed('test@example.com', 'password123')),
    expect: () => [LoginLoading(), LoginFailure('Exception: Error')],
  );
}