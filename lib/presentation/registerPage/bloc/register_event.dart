abstract class RegisterEvent{}

class RegisterEmailChanged extends RegisterEvent{
  final String? email;

  RegisterEmailChanged({this.email});
}

class RegisterUsernameChanged extends RegisterEvent{
  final String? username;

  RegisterUsernameChanged({this.username});
}

class RegisterPasswordChanged extends RegisterEvent{
  final String? password;

  RegisterPasswordChanged({this.password});
}

class RegisterPasswordRepeatChanged extends RegisterEvent{
  final String? passwordRepeat;

  RegisterPasswordRepeatChanged({this.passwordRepeat});
}

class RegisterButtonClickEvent extends RegisterEvent{
  final String? rEmail;
  final String? rUsername;
  final String? rPassword;
  final String? rPasswordRepeat;

  RegisterButtonClickEvent(this.rEmail, this.rUsername, this.rPassword, this.rPasswordRepeat);
}