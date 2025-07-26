import 'package:flutter_bloc/flutter_bloc.dart';

import 'UseCase/ForgotPasswordUseCase.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUseCase forgotUseCase;

  ForgotPasswordBloc(this.forgotUseCase) : super(ForgotInitial()) {
    on<SendForgotPasswordEmail>((event, emit) async {
      emit(ForgotLoading());
      try {
        await forgotUseCase(event.email);
        emit(ForgotSuccess());
      } catch (e) {
        emit(ForgotFailure(e.toString()));
      }
    });
  }
}
