import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ResetPassword/reset_password_bloc.dart';
import 'ResetPassword/reset_password_event.dart';
import 'ResetPassword/reset_password_state.dart';
import 'VerifyCode/verify_code_bloc.dart';
import 'VerifyCode/verify_code_event.dart';
import 'VerifyCode/verify_code_state.dart';
import 'forgot_password_bloc.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';


class ForgetPasswordFlow extends StatefulWidget {
  const ForgetPasswordFlow({super.key});

  @override
  State<ForgetPasswordFlow> createState() => _ForgetPasswordFlowState();
}

class _ForgetPasswordFlowState extends State<ForgetPasswordFlow> {
  int _currentStep = 0;
  final _emailController = TextEditingController();
  final List<TextEditingController> _codeControllers = List.generate(6, (_) => TextEditingController());
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isEmailValid = true;
  bool _isCodeValid = true;

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  void _validateEmail(String email) {
    setState(() {
      _isEmailValid = isEmailValid(email);
    });
  }

  void _validatePasswords(String newPass, String confirmPass) {
    setState(() {
      _isCodeValid = newPass.isNotEmpty &&
          confirmPass.isNotEmpty &&
          newPass == confirmPass &&
          newPass.length >= 6;
    });
  }

  void _nextStep() {
    if (_currentStep == 0) {
      final email = _emailController.text;
      _validateEmail(email);
      if (_isEmailValid) {
        context.read<ForgotPasswordBloc>().add(SendForgotPasswordEmail(email));
      }
    } else if (_currentStep == 1) {
      final codeFilled = _codeControllers.every((c) => c.text.isNotEmpty);
      if (codeFilled) {
        final code = _codeControllers.map((c) => c.text).join();
        context.read<VerifyCodeBloc>().add(SubmitVerificationCode(code));
      } else {
        setState(() => _isCodeValid = false);
      }
    } else if (_currentStep == 2) {
      final newPass = _newPasswordController.text;
      final confirmPass = _confirmPasswordController.text;
      _validatePasswords(newPass, confirmPass);
      if (_isCodeValid) {
        final email = _emailController.text;
        context.read<ResetPasswordBloc>().add(
          SubmitResetPassword(
            email: email,
            newPassword: newPass,
            reNewPassword: confirmPass,
          ),
        );
      }
    }
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (_currentStep == 0) ...[
            Text("Forget password", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16.0),
            Text("Please enter your email associated to your account to reset your password", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              onChanged: _validateEmail,
              decoration: InputDecoration(
                labelText: "Email",
                errorText: _isEmailValid ? null : "This email is not valid",
                border: const OutlineInputBorder(),
              ),
            ),
          ] else if (_currentStep == 1) ...[
            Text("Email verification", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16.0),
            Text("Please enter the 6-digit code sent to your email address", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) => SizedBox(
                width: 45,
                child: TextField(
                  controller: _codeControllers[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: "",
                    border: const OutlineInputBorder(),
                    errorText: _isCodeValid ? null : "",
                  ),
                ),
              )),
            ),
            const SizedBox(height: 16.0),
            TextButton(onPressed: () {}, child: const Text("Didn't receive code? Resend")),
          ] else if (_currentStep == 2) ...[
            Text("Reset password", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16.0),
            Text("Password must not be empty and must contain 0-9 characters with uppercase, lowercase and one number at least", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16.0),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              onChanged: (value) => _validatePasswords(value, _confirmPasswordController.text),
              decoration: const InputDecoration(
                labelText: "New password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              onChanged: (value) => _validatePasswords(_newPasswordController.text, value),
              decoration: InputDecoration(
                labelText: "Confirm password",
                errorText: _isCodeValid ? null : "Passwords do not match",
                border: const OutlineInputBorder(),
              ),
            ),
          ],
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: _nextStep,
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotSuccess) {
              setState(() => _currentStep = 1);
            } else if (state is ForgotFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
        BlocListener<VerifyCodeBloc, VerifyCodeState>(
          listener: (context, state) {
            if (state is VerifySuccess) {
              setState(() => _currentStep = 2);
            } else if (state is VerifyFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
        BlocListener<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Password changed successfully")),
              );
              Navigator.pushReplacementNamed(context, "/login");
            } else if (state is ResetPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),

      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Password")),
        body: _buildBody(context),
      ),
    );
  }
}
