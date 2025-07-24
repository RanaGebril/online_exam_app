import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendForgotPasswordEmail extends ForgotPasswordEvent {
  final String email;

  SendForgotPasswordEmail(this.email);

  @override
  List<Object?> get props => [email];
}
