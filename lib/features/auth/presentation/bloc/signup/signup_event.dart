import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupButtonPressed extends SignupEvent {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  SignupButtonPressed({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  @override
  List<Object?> get props => [
    username,
    firstName,
    lastName,
    email,
    password,
    rePassword,
    phone,
  ];
}
