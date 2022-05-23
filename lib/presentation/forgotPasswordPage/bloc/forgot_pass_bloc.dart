import 'package:new_project/presentation/forgotPasswordPage/bloc/forgot_pass_event.dart';
import 'package:new_project/presentation/forgotPasswordPage/bloc/forgot_pass_state.dart';
import 'package:new_project/presentation/form_submission_status.dart';
import 'package:bloc/bloc.dart';

import '../../../data/repository/repository.dart';

class ForgotPassBloc extends Bloc<ForgotPassEvent, ForgotPassState> {
  final UserRepository? userRepository;

  ForgotPassBloc({this.userRepository}) : super(ForgotPassState()) {
    on<ForgotEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<ForgotButtonClickEvent>((event, emit) async {
      if (event.fEmail == '') {
        emit(ForgotPassState(formStatus: SubmissionFailed(Exception('Email is empty'))));
        return;
      }

      var result = await userRepository?.forgotPass(event.fEmail!);

      if (result!.error == null) {
        emit(ForgotPassState(formStatus: SubmissionSuccess()));
      } else {
        emit(ForgotPassState(formStatus: SubmissionFailed(Exception(result.error))));
      }
    });
  }
}
