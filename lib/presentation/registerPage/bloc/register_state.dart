import 'package:new_project/presentation/form_submission_status.dart';

class RegisterState {
  final String? email;
  final String? username;
  final String? password;
  final String? passwordRepeat;

  final FormSubmissionStatus formStatus;

  RegisterState({
    this.email = '',
    this.username = '',
    this.password = '',
    this.passwordRepeat = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String? email,
    String? username,
    String? password,
    String? passwordRepeat,
    FormSubmissionStatus? formStatus,
  }){
    return RegisterState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      passwordRepeat: passwordRepeat ?? this.passwordRepeat,
    );
  }

}
