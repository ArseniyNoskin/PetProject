import 'package:flutter/material.dart';
import 'package:new_project/presentation/loginPage/login_page_2.dart';
import 'package:new_project/presentation/routes/appRoutes.dart';

class RegisterView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _registerForm(context),
    );
  }

  Widget _registerForm(BuildContext context){
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _emailField(),
            const SizedBox(height: 20,),
            _loginField(),
            const SizedBox(height: 20,),
            _passwordField(),
            const SizedBox(height: 20,),
            _repeatPasswordField(),
            const SizedBox(height: 20,),
            _registerButton(myOnClick: (){
              Navigator.pushNamed(context, AppRoutes.login);
            }),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return const TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        border: OutlineInputBorder(),
        labelText: 'Email',
        hintText: 'Enter your valid email',
      ),
    );
  }

  Widget _loginField() {
    return const TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        border: OutlineInputBorder(),
        labelText: 'Login',
        hintText: 'Enter your secure login',
      ),
    );
  }

  Widget _passwordField() {
    return const TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.security),
        border: OutlineInputBorder(),
        labelText: 'New password',
        hintText: 'Enter your secure password',
      ),
    );
  }

  Widget _repeatPasswordField() {
    return const TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.security),
        border: OutlineInputBorder(),
        labelText: 'Repeat password',
        hintText: 'Repeat your password',
      ),
    );
  }

  Widget _registerButton({required void Function() myOnClick}) {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: (){
          myOnClick();
        },
        child: const Text(
          'Register',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}
