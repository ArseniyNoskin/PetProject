import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/presentation/codeEntryPage/code_entry_page.dart';
import 'package:new_project/presentation/forgotPasswordPage/forgot_password_page.dart';
import 'package:new_project/presentation/loginPage/login_page_2.dart';
import 'package:new_project/presentation/newPasswordPage/new_password_page.dart';
import 'package:new_project/presentation/registerPage/register_page.dart';
import 'package:new_project/presentation/routes/appRoutes.dart';
import 'package:new_project/repository/repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.login: (context) => RepositoryProvider(
                create: (context) => UserRepository(),
                child: LoginView(),
              ),
          AppRoutes.forgotPass: (context) => ForgotPasswordView(),
          AppRoutes.newPass: (context) => NewPasswordView(),
          AppRoutes.codeEntry: (context) => CodeEntryView(),
          AppRoutes.register: (context) => RegisterView(),
        },
    );
  }
}
