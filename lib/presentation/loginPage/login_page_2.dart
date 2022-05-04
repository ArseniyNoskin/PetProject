import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/presentation/routes/appRoutes.dart';
import 'package:new_project/repository/repository.dart';
import '../form_submission_status.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

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
            _showSnackBar(context, 'Hi Arsen');
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                _usernameField(),
                _passwordField(),
                const SizedBox(
                  height: 20,
                ),
                _forgotPasTextBut(myOnClick:() {
                  Navigator.pushNamed(
                      context,
                      AppRoutes.forgotPass
                  );
                }),
                _loginButton(),
                const SizedBox(
                  height: 300,
                ),
                _registerTextBut(myOnClick: (){
                  Navigator.pushNamed(context, AppRoutes.register);
                }),
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Username',
        ),
        validator: (value) =>
            state.isValidUsername ? null : 'Username is too short',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginUsernameChanged(username: value),
            ),
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
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginPasswordChanged(password: value),
            ),
      );
    });
  }

  Widget _forgotPasTextBut({required Null Function() myOnClick} ){
    return TextButton(
      onPressed: (){
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
                context.read<LoginBloc>().add(LoginSubmitted(state.username, state.password));
              },
              child: const Text('Login'),
            );
    });
  }

  Widget _registerTextBut({required void Function() myOnClick}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'New user? ',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        TextButton(
          onPressed: (){
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
