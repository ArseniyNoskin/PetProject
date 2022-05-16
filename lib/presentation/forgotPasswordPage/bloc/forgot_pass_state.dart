import 'package:new_project/presentation/form_submission_status.dart';

class ForgotPassState{
  final String? email;

  final FormSubmissionStatus formStatus;

  ForgotPassState({this.email, this.formStatus = const InitialFormStatus()});

  ForgotPassState copyWith({
    String? email,
    FormSubmissionStatus? formStatus
  }){
    return ForgotPassState(
      email: email ?? this.email
    );
  }
}