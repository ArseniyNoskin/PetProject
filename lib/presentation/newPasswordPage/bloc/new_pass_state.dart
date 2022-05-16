import 'package:new_project/presentation/form_submission_status.dart';

class NewPassState{
  final String? password;
  final String? passwordRepeat;

  final FormSubmissionStatus formStatus;

  NewPassState({this.password, this.passwordRepeat, this.formStatus = const InitialFormStatus()});

  NewPassState copyWith({
    String? password,
    String? passwordRepeat,
    FormSubmissionStatus? formStatus
  }){
    return NewPassState(
      password: password ?? this.password,
      passwordRepeat: passwordRepeat ?? this.passwordRepeat,
    );
  }
}