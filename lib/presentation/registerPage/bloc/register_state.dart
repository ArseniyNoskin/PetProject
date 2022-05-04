class RegisterState {
  final String? email;
  final String? username;
  final String? password;
  final String? passwordRepeat;

  RegisterState({
    this.email = '',
    this.username = '',
    this.password = '',
    this.passwordRepeat = '',
  });

  RegisterState copyWith({
    String? email,
    String? username,
    String? password,
    String? passwordRepeat,
  }){
    return RegisterState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      passwordRepeat: passwordRepeat ?? this.passwordRepeat,
    );
  }

}
