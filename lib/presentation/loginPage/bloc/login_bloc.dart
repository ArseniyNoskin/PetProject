import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import 'package:new_project/presentation/loginPage/bloc/login_event.dart';
import 'package:new_project/presentation/loginPage/bloc/login_state.dart';
import 'package:new_project/repository/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository? userRepository;

  LoginBloc({this.userRepository}) : super(LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(username: event.email, formStatus: const InitialFormStatus()));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      await Future.delayed(const Duration(seconds: 2));

      if (event.email == '') {
        emit(LoginState(formStatus: SubmissionFailed(Exception('Login is empty'))));
        return;
      }

      if (event.password == '') {
        emit(LoginState(formStatus: SubmissionFailed(Exception('Password is empty'))));
        return;
      }

      var result = await userRepository?.login(event.email!, event.password!);
      if (result!.error == null) {
        emit(LoginState(formStatus: SubmissionSuccess()));
      } else {
        emit(LoginState(formStatus: SubmissionFailed(Exception(result.error))));
      }
    });
  }
}
