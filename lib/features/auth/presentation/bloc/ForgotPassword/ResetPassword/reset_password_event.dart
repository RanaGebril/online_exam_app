import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitResetPassword extends ResetPasswordEvent {
  final String email;
  final String newPassword;
  final String reNewPassword;

  SubmitResetPassword({
    required this.email,
    required this.newPassword,
    required this.reNewPassword,
  });

  @override
  List<Object?> get props => [email, newPassword, reNewPassword];
}
