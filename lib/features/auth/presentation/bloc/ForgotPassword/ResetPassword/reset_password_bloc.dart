import 'package:flutter_bloc/flutter_bloc.dart';
import '../UseCase/reset_password_usecase.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase useCase;

  ResetPasswordBloc(this.useCase) : super(ResetPasswordInitial()) {
    on<SubmitResetPassword>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        await useCase(
          email: event.email,
          newPassword: event.newPassword,
          reNewPassword: event.reNewPassword,
        );
        emit(ResetPasswordSuccess());
      } catch (e) {
        emit(ResetPasswordFailure(e.toString()));
      }
    });
  }
}
