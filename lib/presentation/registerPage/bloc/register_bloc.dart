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

    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      await Future.delayed(const Duration(seconds: 2));

      if (event.username == null) {
        emit(RegisterState(formStatus: SubmissionFailed(Exception('Username is empty'))));
        return;
      }
      if (event.email == null) {
        emit(RegisterState(formStatus: SubmissionFailed(Exception('Email is empty'))));
        return;
      }
      if (event.password == null) {
        emit(RegisterState(formStatus: SubmissionFailed(Exception('Password is empty'))));
        return;
      }
      if (event.passwordRepeat == null) {
        emit(RegisterState(formStatus: SubmissionFailed(Exception('Repeat password is empty'))));
        return;
      }

      var result = await userRepository?.register(event.email!, event.username!, event.password!, event.passwordRepeat!);

      if (result!.error!.isEmpty){
        emit(RegisterState(formStatus: SubmissionSuccess()));
      }else{
        print(result.error);
        emit(RegisterState(formStatus: SubmissionFailed(Exception(result.error))));
      }


    });
  }

}