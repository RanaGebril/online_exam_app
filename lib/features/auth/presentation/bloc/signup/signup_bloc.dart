import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../profile/data/datasources/user_local_storage.dart';
import '../../../../profile/data/models/user_profile_model.dart';
import '../../../domain/usecases.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUseCase signupUseCase;

  SignupBloc(this.signupUseCase) : super(SignupInitial()) {
    on<SignupButtonPressed>((event, emit) async {
      emit(SignupLoading());

      try {
        final user = await signupUseCase(
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
          rePassword: event.rePassword,
          phone: event.phone,
        );

        final profile = UserProfileModel.fromUserModel(user );
        await UserLocalStorage.saveUser(profile);

        emit(SignupSuccess());
      } catch (e) {
        if (e is DioError) {
          final errorMessage = e.response?.data['message'] ??
              e.response?.data['error'] ??
              e.message;
          emit(SignupFailure(errorMessage));
        } else {
          emit(SignupFailure(e.toString()));
        }
      }
    });
  }
}
