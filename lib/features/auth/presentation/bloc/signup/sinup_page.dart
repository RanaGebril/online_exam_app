import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../data/remote/auth_api_client.dart';
import '../../../data/datasources.dart';
import '../../../data/repositories.dart';
import '../../../domain/usecases.dart';
import 'signup_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dio = Dio();
        final apiClient = AuthApiClient(dio);
        final datasource = AuthRemoteDatasource(apiClient);
        final repository = AuthRepositoryImpl(datasource);
        final useCase = SignupUseCase(repository);
        return SignupBloc(useCase);
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Sign up")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<SignupBloc, SignupState>(
            listener: (context, state) {
              if (state is SignupFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              } else if (state is SignupSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Signup Success ✅")),
                );
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Enter your username",
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                              labelText: "First name",
                              hintText: "Enter first name",
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: TextField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                              labelText: "Last name",
                              hintText: "Enter last name",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email",
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter password",
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Confirm password",
                              hintText: "Confirm password",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone number",
                        hintText: "Enter phone number",
                      ),
                    ),
                    SizedBox(height: 32.0),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child:ElevatedButton(
                        onPressed: () {
                          final username = usernameController.text.trim();
                          final firstName = firstNameController.text.trim();
                          final lastName = lastNameController.text.trim();
                          final email = emailController.text.trim();
                          final phone = phoneController.text.trim();
                          final pass = passwordController.text.trim();
                          final confirmPass = confirmPasswordController.text.trim();
                          if (username.isEmpty ||
                              firstName.isEmpty ||
                              lastName.isEmpty ||
                              email.isEmpty ||
                              phone.isEmpty ||
                              pass.isEmpty ||
                              confirmPass.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please fill in all fields")),
                            );
                            return;
                          }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(email)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Invalid email format")),
                            );
                            return;
                          }
                          if (pass != confirmPass) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Passwords do not match")),
                            );
                            return;
                          }
                          context.read<SignupBloc>().add(
                            SignupButtonPressed(
                              username: username,
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              password: pass,
                              rePassword: confirmPass,
                              phone: phone,
                            ),
                          );
                        },
                        child: Text("Signup"),
                      )
                    ),
                    SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextSpan(
                              text: "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}