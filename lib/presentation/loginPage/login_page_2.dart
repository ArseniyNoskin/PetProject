import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/presentation/routes/appRoutes.dart';
import '../../data/repository/repository.dart';
import '../form_submission_status.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          userRepository: context.read<UserRepository>(),
        ),
        child: _loginForm(context),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
          if (formStatus is SubmissionSuccess) {
            Navigator.pushNamed(context, AppRoutes.listHeroes);
          }
        },
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                _emailField(),
                _passwordField(),
                const SizedBox(
                  height: 20,
                ),
                _forgotPasTextBut(myOnClick: () {
                  Navigator.pushNamed(context, AppRoutes.forgotPass);
                }),
                _loginButton(),
                const SizedBox(
                  height: 300,
                ),
                _registerTextBut(myOnClick: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                }),
              ],
            ),
          ),
        ));
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.email),
          hintText: 'Email',
        ),
        controller: emailController,
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
        controller: passwordController,
      );
    });
  }

  Widget _forgotPasTextBut({required Null Function() myOnClick}) {
    return TextButton(
      onPressed: () {
        myOnClick();
      },
      child: const Text(
        'Forgot Password',
        style: TextStyle(color: Colors.blueAccent, fontSize: 15),
      ),
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                context
                    .read<LoginBloc>()
                    .add(LoginSubmitted(emailController.text.trim(), passwordController.text.trim()));
              },
              child: const Text('Login'),
            );
    });
  }

  Widget _registerTextBut({required void Function() myOnClick}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'New user? ',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        TextButton(
          onPressed: () {
            myOnClick();
          },
          child: const Text(
            'Create account',
            style: TextStyle(color: Colors.blueAccent, fontSize: 15),
          ),
        )
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
