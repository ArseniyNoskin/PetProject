import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/presentation/registerPage/bloc/register_event.dart';
import 'package:new_project/presentation/registerPage/bloc/register_state.dart';

import '../../data/repository/repository.dart';
import '../form_submission_status.dart';
import '../routes/appRoutes.dart';
import 'bloc/register_bloc.dart';

class RegisterView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterView({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterBloc(
          userRepository: context.read<UserRepository>(),
        ),
        child: _registerForm(context),
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        final formStatus = state.formStatus;

        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
        if (formStatus is SubmissionSuccess) {
          Navigator.pushNamed(
            context,
            AppRoutes.login,
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emailField(),
              const SizedBox(
                height: 20,
              ),
              _loginField(),
              const SizedBox(
                height: 20,
              ),
              _passwordField(),
              const SizedBox(
                height: 20,
              ),
              _repeatPasswordField(),
              const SizedBox(
                height: 20,
              ),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      decoration: const InputDecoration(
        icon: Icon(Icons.email),
        border: OutlineInputBorder(),
        labelText: 'Email',
        hintText: 'Enter your valid email',
      ),
      controller: emailController,
    );
  }

  Widget _loginField() {
    return TextField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        border: OutlineInputBorder(),
        labelText: 'Login',
        hintText: 'Enter your secure login',
      ),
      controller: usernameController,
    );
  }

  Widget _passwordField() {
    return TextField(
      decoration: const InputDecoration(
        icon: Icon(Icons.security),
        border: OutlineInputBorder(),
        labelText: 'New password',
        hintText: 'Enter your secure password',
      ),
      obscureText: true,
      controller: passwordController,
    );
  }

  Widget _repeatPasswordField() {
    return TextField(
      decoration: const InputDecoration(
        icon: Icon(Icons.security),
        border: OutlineInputBorder(),
        labelText: 'Repeat password',
        hintText: 'Repeat your password',
      ),
      obscureText: true,
      controller: passwordRepeatController,
    );
  }

  Widget _registerButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                context.read<RegisterBloc>().add(RegisterButtonClickEvent(
                    emailController.text.trim(),
                    usernameController.text.trim(),
                    passwordController.text.trim(),
                    passwordRepeatController.text.trim()));
              },
              child: const Text('Register'),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
