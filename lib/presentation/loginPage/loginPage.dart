import 'package:flutter/material.dart';

import '../forgotPasswordPage/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/dota2Logo.png'),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 50, bottom: 0, left: 15, right: 15),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'Enter your valid username',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 50, left: 15, right: 15),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.security),
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
            ),
          ),
          TextButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ForgotPasswordView()),
              );
            },
            child: const Text(
              'Forgot password',
              style: TextStyle(color: Colors.blueAccent, fontSize: 15),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: (){

              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
