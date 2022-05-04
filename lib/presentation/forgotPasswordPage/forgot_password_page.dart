import 'package:flutter/material.dart';
import 'package:new_project/presentation/codeEntryPage/code_entry_page.dart';
import 'package:new_project/presentation/routes/appRoutes.dart';

class ForgotPasswordView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _forgotPasswordForm(context),
    );
  }

  Widget _forgotPasswordForm(BuildContext context){
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
            _sendCodeButton(myOnClick: () {
              Navigator.pushNamed(
                  context,
                  AppRoutes.codeEntry
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _emailField(){
    return const TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        border: OutlineInputBorder(),
        labelText: 'Email',
        hintText: 'Enter your valid email',
      ),
    );
  }

  Widget _loginField(){
    return const TextField(
      decoration: InputDecoration(
          icon: Icon(Icons.person),
          border: OutlineInputBorder(),
          labelText: 'Login',
          hintText: 'Enter your valid login'
      ),
    );
  }

  Widget _sendCodeButton({required Null Function() myOnClick}){
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
          'Send code',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}
