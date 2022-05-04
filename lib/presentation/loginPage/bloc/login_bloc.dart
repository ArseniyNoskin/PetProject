import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import 'package:new_project/presentation/loginPage/bloc/login_event.dart';
import 'package:new_project/presentation/loginPage/bloc/login_state.dart';
import 'package:new_project/repository/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository? userRepository;

  LoginBloc({this.userRepository}) : super(LoginState()) {
    on<LoginUsernameChanged>((event, emit) {
      if (kDebugMode) {
        print('HERE');
      }
      emit(state.copyWith(username: event.username));
    });

    on<LoginPasswordChanged>((event, emit) {
      if (kDebugMode) {
        print('HERE');
      }
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      await Future.delayed(const Duration(seconds: 2));
      if (kDebugMode) {
        print('success');
      }

      if (event.login == null) {
        emit(LoginState(formStatus: SubmissionFailed(Exception('Login is empty'))));
        return;
      }

      var result = await userRepository?.login(event.login!, event.password!);
      if (result!.error!.isEmpty) {
        if (kDebugMode) {
          print('fail');
        }
        emit(LoginState(formStatus: SubmissionSuccess()));
      } else {
        emit(LoginState(formStatus: SubmissionFailed(Exception(result.error))));
      }
    });
  }
}
