import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable{
  @override
  List<Object?> get props => [];
}
class ForgotInitial extends ForgotPasswordState {}
class ForgotLoading extends ForgotPasswordState {}
class ForgotSuccess extends ForgotPasswordState {}
class ForgotFailure extends ForgotPasswordState {
  final String message;
  ForgotFailure(this.message);

  @override
  List<Object?> get props => [message];
}