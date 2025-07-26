import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/VerifyCode/verify_code_event.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/VerifyCode/verify_code_state.dart';

import '../UseCase/verify_reset_code_use_case.dart';

class VerifyCodeBloc extends Bloc<VerifyCodeEvent, VerifyCodeState> {
  final VerifyResetCodeUseCase useCase;

  VerifyCodeBloc(this.useCase) : super(VerifyInitial()) {
    on<SubmitVerificationCode>((event, emit) async {
      emit(VerifyLoading());
      try {
        await useCase(event.code);
        emit(VerifySuccess());
      } catch (e) {
        emit(VerifyFailure(e.toString()));
      }
    });
  }
}
