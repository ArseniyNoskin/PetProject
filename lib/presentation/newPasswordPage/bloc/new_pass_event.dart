abstract class NewPassEvent{}

class PasswordChanged extends NewPassEvent{
  final String? password;

  PasswordChanged({this.password});
}

class PasswordRepeatChanged extends NewPassEvent{
  final String? passwordRepeat;

  PasswordRepeatChanged({this.passwordRepeat});
}

class UpdatePassButtonClickEvent extends NewPassEvent{
  final String? uEmail;
  final String? uPassword;
  final String? uPasswordRepeat;

  UpdatePassButtonClickEvent(this.uEmail, this.uPassword, this.uPasswordRepeat);
}