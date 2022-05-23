import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/presentation/forgotPasswordPage/bloc/forgot_pass_bloc.dart';
import 'package:new_project/presentation/forgotPasswordPage/bloc/forgot_pass_event.dart';
import 'package:new_project/presentation/forgotPasswordPage/bloc/forgot_pass_state.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import 'package:new_project/presentation/routes/appRoutes.dart';

import '../../data/repository/repository.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({Key? key}) : super(key: key);

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ForgotPassBloc(userRepository: context.read<UserRepository>()),
        child: _forgotPasswordForm(context),
      ),
    );
  }

  Widget _forgotPasswordForm(BuildContext context) {
    return BlocListener<ForgotPassBloc, ForgotPassState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        } else {
          Navigator.pushNamed(context, AppRoutes.newPass, arguments: emailController.text.trim());
        }
      },
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emailField(),
              const SizedBox(
                height: 20,
              ),
              _sendCodeButton()
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

  Widget _sendCodeButton() {
    return BlocBuilder<ForgotPassBloc, ForgotPassState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                context.read<ForgotPassBloc>().add(ForgotButtonClickEvent(emailController.text.trim()));
              },
              child: const Text('Enter'));
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
