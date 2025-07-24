import 'package:equatable/equatable.dart';

abstract class VerifyCodeState extends Equatable{
  @override
  List<Object?> get props => [];

}
class VerifyInitial extends VerifyCodeState {}
class VerifyLoading extends VerifyCodeState {}
class VerifySuccess extends VerifyCodeState {}
class VerifyFailure extends VerifyCodeState {
  final String message;

  VerifyFailure(this.message);

  @override
  List<Object?> get props => [message];
}