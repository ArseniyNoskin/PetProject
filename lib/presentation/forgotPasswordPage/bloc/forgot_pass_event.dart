abstract class ForgotPassEvent{}

class ForgotEmailChanged extends ForgotPassEvent{
  final String? email;

  ForgotEmailChanged({this.email});
}

class ForgotButtonClickEvent extends ForgotPassEvent{
  final String? fEmail;

  ForgotButtonClickEvent(this.fEmail);
}