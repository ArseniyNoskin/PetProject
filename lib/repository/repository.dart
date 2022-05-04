import 'package:new_project/models/repository_result.dart';
import 'package:new_project/models/user_data_model.dart';

class UserRepository{

  String? userUsername;
  String? userPassword;
  String? userEmail;
  int? userAge;

  Future<RepositoryResult> login(String login, String password) async{

    await Future.delayed(const Duration(seconds: 2));
    print('entered login =  ${login}, in repos saved = ${userUsername}');
    if(login == userUsername && password == userPassword){
      return RepositoryResult(success: UserDataModel(userEmail, userUsername, 19), error: null);
    }else{
      return RepositoryResult(success: UserDataModel(null, null, null), error: 'invalid username');
    }
  }

  Future<RepositoryResult> register(String email, String username, String password, String passwordRepeat) async{
    await Future.delayed(const Duration(seconds: 2));
    if (password == passwordRepeat){
      userUsername = username;
      userEmail = email;
      userPassword = password;
      return RepositoryResult(success: UserDataModel(email, username, 19), error: null);
    }else{
      return RepositoryResult(success: UserDataModel(null, null, null), error: 'password don`t match');
    }
  }
}