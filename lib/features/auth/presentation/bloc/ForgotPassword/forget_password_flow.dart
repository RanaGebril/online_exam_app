import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'VerifyCode/verify_code_event.dart';
import 'VerifyCode/verify_code_bloc.dart';
import 'forgot_password_event.dart';
import 'forgot_password_bloc.dart';
import 'ResetPassword/reset_password_bloc.dart';
import 'ResetPassword/reset_password_event.dart';

class ForgetPasswordFlow extends StatefulWidget {
  const ForgetPasswordFlow({super.key});

  @override
  _ForgetPasswordFlowState createState() => _ForgetPasswordFlowState();
}

class _ForgetPasswordFlowState extends State<ForgetPasswordFlow> {
  int _currentStep = 0;
  final _emailController = TextEditingController();
  final List<TextEditingController> _codeControllers = List.generate(4, (_) => TextEditingController());
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isEmailValid = true;
  bool _isCodeValid = true;

  bool isEmailValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[Z0-9.a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$',
    );
    return emailRegex.hasMatch(email);
  }

  void _validateEmail(String email) {
    setState(() {
      _isEmailValid = isEmailValid(email);
    });
  }

  void _validatePasswords(String newPass, String confirmPass) {
    setState(() {
      _isCodeValid = newPass.isNotEmpty && confirmPass.isNotEmpty && newPass == confirmPass && newPass.length >= 6;
    });
  }

  void _nextStep() {
    if (_currentStep == 0) {
      final email = _emailController.text;
      _validateEmail(email);
      if (_isEmailValid) {
        context.read<ForgotPasswordBloc>().add(SendForgotPasswordEmail(email));
        setState(() => _currentStep = 1);
      }
    } else if (_currentStep == 1) {
      final codeFilled = _codeControllers.every((c) => c.text.isNotEmpty);
      if (codeFilled) {
        final code = _codeControllers.map((c) => c.text).join();
        context.read<VerifyCodeBloc>().add(SubmitVerificationCode(code));
        setState(() => _currentStep = 2);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_currentStep == 0) ...[
              Text("Forget password", style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 16.0),
              Text("Please enter your email associated to your account to reset your password", style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                onChanged: _validateEmail,
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: _isEmailValid ? null : "This email is not valid",
                  border: OutlineInputBorder(),
                ),
              ),
            ] else if (_currentStep == 1) ...[
              Text("Email verification", style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 16.0),
              Text("Please enter code that send to your email address", style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) => SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _codeControllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                      errorText: _isCodeValid ? null : "Invalid code",
                    ),
                  ),
                )),
              ),
              SizedBox(height: 16.0),
              TextButton(onPressed: () {}, child: Text("Didn't receive code? Resend")),
            ] else if (_currentStep == 2) ...[
              Text("Reset password", style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 16.0),
              Text("Password must not be empty and must contain 0-9 characters with uppercase, lowercase and one number at least", style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 16.0),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                onChanged: (value) => _validatePasswords(value, _confirmPasswordController.text),
                decoration: InputDecoration(
                  labelText: "New password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                onChanged: (value) => _validatePasswords(_newPasswordController.text, value),
                decoration: InputDecoration(
                  labelText: "Confirm password",
                  errorText: _isCodeValid ? null : "Passwords do not match",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            SizedBox(height: 35,),
            ElevatedButton(
              onPressed: _nextStep,
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
