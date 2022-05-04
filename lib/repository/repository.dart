import 'package:flutter/cupertino.dart';
import 'package:new_project/repository/user_data_model.dart';

class UserRepository{
  Future<UserDataModel> login(String login, String password) async{

    await Future.delayed(const Duration(seconds: 2));

    if(login == 'Arsenio'){
      return UserDataModel(null, 'arsenio@gmail.com', 'Arsenio', 19);
    }else{
      return UserDataModel('Error username', null, null, null);
    }
  }

  Future<void> register(String email, String username, String password, String passwordRepeat) async{
    await Future.delayed(const Duration(seconds: 2));

    if (password == passwordRepeat){
      return ;
    }else{
      return ;
    }
  }
}

