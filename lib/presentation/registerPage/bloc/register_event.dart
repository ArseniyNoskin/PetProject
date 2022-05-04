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

class RegisterSubmitted extends RegisterEvent{
  final String? email;
  final String? username;
  final String? password;
  final String? passwordRepeat;

  RegisterSubmitted({this.email, this.username, this.password, this.passwordRepeat});
}