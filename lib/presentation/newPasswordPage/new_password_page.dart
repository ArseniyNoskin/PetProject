import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import 'package:new_project/presentation/newPasswordPage/bloc/new_pass_event.dart';
import 'package:new_project/presentation/routes/appRoutes.dart';
import 'package:new_project/repository/repository.dart';

import 'bloc/new_pass_bloc.dart';
import 'bloc/new_pass_state.dart';

class NewPasswordView extends StatelessWidget {
  var email = "";

  final passwordController = TextEditingController();
  final passwordRepeatController = TextEditingController();

  NewPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    email = args;

    return Scaffold(
      body: BlocProvider(
        create: (context) => NewPassBloc(userRepository: context.read<UserRepository>()),
        child: _newPasswordForm(context),
      ),
    );
  }

  Widget _newPasswordForm(BuildContext context) {
    return BlocListener<NewPassBloc, NewPassState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        } else {
          Navigator.pushNamed(context, AppRoutes.login);
        }
      },
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _titleText(),
              const SizedBox(
                height: 20,
              ),
              _newPasswordField(),
              const SizedBox(
                height: 20,
              ),
              _repeatNewPasswordField(),
              const SizedBox(
                height: 20,
              ),
              _sendNewPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleText() {
    return const Text(
      'Введите новый пароль',
      style: TextStyle(color: Colors.black, fontSize: 20),
    );
  }

  Widget _newPasswordField() {
    return TextField(
      decoration: const InputDecoration(
        icon: Icon(Icons.security),
        border: OutlineInputBorder(),
        labelText: 'New password',
        hintText: 'Enter new secure password',
      ),
      obscureText: true,
      controller: passwordController,
    );
  }

  Widget _repeatNewPasswordField() {
    return TextField(
      decoration: const InputDecoration(
          icon: Icon(Icons.security),
          border: OutlineInputBorder(),
          labelText: 'Repeat new password',
          hintText: 'Repeat new password'),
      obscureText: true,
      controller: passwordRepeatController,
    );
  }

  Widget _sendNewPasswordButton() {
    return BlocBuilder<NewPassBloc, NewPassState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                context
                    .read<NewPassBloc>()
                    .add(UpdatePassButtonClickEvent(email, passwordController.text, passwordRepeatController.text));
              },
              child: const Text('Update password'),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
