import 'package:equatable/equatable.dart';

abstract class VerifyCodeEvent  extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitVerificationCode  extends VerifyCodeEvent  {
  final String code;

  SubmitVerificationCode (this.code);

  @override
  List<Object?> get props => [code];
}
