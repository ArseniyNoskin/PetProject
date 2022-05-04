import 'package:flutter/cupertino.dart';
import 'package:new_project/models/repository_result.dart';
import 'package:new_project/models/user_data_model.dart';

class UserRepository{
  Future<RepositoryResult> login(String login, String password) async{

    await Future.delayed(const Duration(seconds: 2));

    if(login == 'Arsenio'){
      return RepositoryResult(success: UserDataModel(null, 'arsenio@gmail.com', 'Arsenio', 19), error: null);
    }else{
      return RepositoryResult(success: UserDataModel('Error username', null, null, null), error: 'invalid username');
    }
  }

  Future<RepositoryResult> register(String email, String username, String password, String passwordRepeat) async{
    await Future.delayed(const Duration(seconds: 2));
    if (password == passwordRepeat){
      return RepositoryResult(success: UserDataModel(null, email, username, 19), error: null);
    }else{
      return RepositoryResult(success: UserDataModel('Error password', null, null, null), error: 'password don`t match');
    }
  }
}