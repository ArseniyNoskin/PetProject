import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/presentation/forgotPasswordPage/forgot_password_page.dart';
import 'package:new_project/presentation/loginPage/login_page_2.dart';
import 'package:new_project/presentation/registerPage/register_page.dart';
import 'package:new_project/presentation/routes/appRoutes.dart';

import '../../repository/repository.dart';

class NewPasswordView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  NewPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _newPasswordForm(context),
    );
  }

  Widget _newPasswordForm(BuildContext context) {
    return Form(
      key: _formKey,
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
            _sendNewPasswordButton(myOnClick: (){
              Navigator.pushNamed(context, AppRoutes.login);
            }),
          ],
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
    return const TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.security),
        border: OutlineInputBorder(),
        labelText: 'New password',
        hintText: 'Enter new secure password',
      ),
    );
  }

  Widget _repeatNewPasswordField() {
    return const TextField(
      decoration: InputDecoration(
          icon: Icon(Icons.security),
          border: OutlineInputBorder(),
          labelText: 'Repeat new password',
          hintText: 'Repeat new password'),
    );
  }

  Widget _sendNewPasswordButton({required void Function() myOnClick}) {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () {
          myOnClick();
        },
        child: const Text(
          'Change password',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}
