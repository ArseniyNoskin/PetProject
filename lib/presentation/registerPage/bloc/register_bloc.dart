import 'package:new_project/presentation/registerPage/bloc/register_event.dart';
import 'package:new_project/presentation/registerPage/bloc/register_state.dart';
import 'package:new_project/repository/repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final UserRepository? userRepository;

}