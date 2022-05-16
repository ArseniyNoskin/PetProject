import 'package:bloc/bloc.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import 'package:new_project/presentation/newPasswordPage/bloc/new_pass_event.dart';
import 'package:new_project/presentation/newPasswordPage/bloc/new_pass_state.dart';
import 'package:new_project/repository/repository.dart';

class NewPassBloc extends Bloc<NewPassEvent, NewPassState>{
  final UserRepository? userRepository;

  NewPassBloc({this.userRepository}) : super(NewPassState()){
    on<PasswordChanged> ((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<PasswordRepeatChanged> ((event, emit){
      emit(state.copyWith(passwordRepeat: event.passwordRepeat));
    });

    on<UpdatePassButtonClickEvent>((event, emit) async{
      if(event.uPassword == ''){
        emit(NewPassState(formStatus: SubmissionFailed(Exception('Password is empty'))));
        return;
      }
      if(event.uPasswordRepeat == ''){
        emit(NewPassState(formStatus: SubmissionFailed(Exception('Repeat password is empty'))));
        return;
      }

      var result = await userRepository?.updatePass(event.uEmail!, event.uPassword!, event.uPasswordRepeat!);

      if (result!.error == null){
        emit(NewPassState(formStatus: SubmissionSuccess()));
      }else{
        emit(NewPassState(formStatus: SubmissionFailed(Exception(result.error))));
      }
    });
  }
}