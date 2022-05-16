import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import 'package:new_project/presentation/registerPage/bloc/register_event.dart';
import 'package:new_project/presentation/registerPage/bloc/register_state.dart';
import 'package:new_project/repository/repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final UserRepository? userRepository;

  RegisterBloc({this.userRepository}) : super(RegisterState()){
    on<RegisterUsernameChanged>((event, emit){
      emit(state.copyWith(username: event.username));
    });

    on<RegisterEmailChanged>((event, emit){
      emit(state.copyWith(email: event.email));
    });

    on<RegisterPasswordChanged>((event, emit){
      emit(state.copyWith(password: event.password));
    });

    on<RegisterPasswordRepeatChanged>((event, emit) {
      emit(state.copyWith(passwordRepeat: event.passwordRepeat));
    });

    on<RegisterButtonClickEvent>((event, emit) async {
      if (event.rEmail == '') {
        emit(RegisterState(formStatus: SubmissionFailed(Exception('Email is empty'))));
        return;
      }
      if (event.rUsername == '') {
        emit(RegisterState(formStatus: SubmissionFailed(Exception('Username is empty'))));
        return;
      }
      if (event.rPassword == '') {
        emit(RegisterState(formStatus: SubmissionFailed(Exception('Password is empty'))));
        return;
      }
      if (event.rPasswordRepeat == '') {
        emit(RegisterState(formStatus: SubmissionFailed(Exception('Repeat password is empty'))));
        return;
      }

      var result = await userRepository?.register(event.rEmail!, event.rUsername!, event.rPassword!, event.rPasswordRepeat!);

      if (result!.error == null){
        emit(RegisterState(formStatus: SubmissionSuccess()));
      }else{
        emit(RegisterState(formStatus: SubmissionFailed(Exception(result.error))));
      }
    });
  }

}