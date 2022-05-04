import 'package:flutter/material.dart';
import 'package:new_project/presentation/newPasswordPage/new_password_page.dart';
import 'package:new_project/presentation/routes/appRoutes.dart';

import '../forgotPasswordPage/forgot_password_page.dart';

class CodeEntryView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  CodeEntryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _codeEntryForm(context),
    );
  }

  Widget _codeEntryForm(BuildContext context){
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _titleText(),
            const SizedBox(height: 20,),
            _codeField(),
            const SizedBox(height: 20,),
            _sendCodeButton(myOnClick: (){
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NewPasswordView()),
              );*/
              Navigator.pushNamed(context, AppRoutes.newPass);
            }),
          ],
        ),
      ),
    );
  }

  Widget _titleText(){
    return const Text(
      'Введите код отправленый на Вашу почту',
      style: TextStyle(color: Colors.black, fontSize: 20),
    );
  }

  Widget _codeField(){
    return const TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.key),
        border: OutlineInputBorder(),
        labelText: 'Code',
        hintText: 'Enter code from your email',
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
