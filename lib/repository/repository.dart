import 'package:new_project/models/repository_result.dart';
import 'package:new_project/models/user_data_model.dart';

import '../database/database.dart';
import '../database/entity/person.dart';

class UserRepository {
  String nameDatabase = 'my_test_database.db';

  Future<RepositoryResult> updatePass(String email, String password, String passwordRepeat) async {
    final database = await $FloorAppDatabase.databaseBuilder(nameDatabase).build();
    final personDao = database.personDao;
    final result = await personDao.findPersonByEmail(email);
    await Future.delayed(const Duration(seconds: 1));
    if (password == passwordRepeat) {
      await personDao.updatePassword(email, password);
      return RepositoryResult(success: true, error: null);
    } else {
      return RepositoryResult(success: null, error: 'password don`t match');
    }
  }

  Future<RepositoryResult> forgotPass(String email) async {
    final database = await $FloorAppDatabase.databaseBuilder(nameDatabase).build();
    final personDao = database.personDao;
    final result = await personDao.findPersonByEmail(email);
    await Future.delayed(const Duration(seconds: 1));
    if (result == null) {
      return RepositoryResult(success: null, error: 'invalid email');
    } else {
      return RepositoryResult(success: true, error: null);
    }
  }

  Future<RepositoryResult> login(String email, String password) async {
    final database = await $FloorAppDatabase.databaseBuilder(nameDatabase).build();
    final personDao = database.personDao;
    final result = await personDao.findPersonByEmail(email);
    await Future.delayed(const Duration(seconds: 1));
    if (result == null) {
      return RepositoryResult(success: null, error: 'invalid email');
    } else {
      if (result.password == password) {
        return RepositoryResult(success: UserDataModel(result.email, result.username, result.age), error: null);
      } else {
        return RepositoryResult(success: null, error: 'invalid password');
      }
    }
  }

  Future<RepositoryResult> register(String email, String username, String password, String passwordRepeat) async {
    final database = await $FloorAppDatabase.databaseBuilder(nameDatabase).build();
    await Future.delayed(const Duration(seconds: 1));
    final personDao = database.personDao;
    final person = Person(null, username, email, password, 19);

    if (password == passwordRepeat) {
      try {
        await personDao.insertPerson(person);
      }
      /*on DataBaseException catch(e){

      } */
      on Exception catch (e) {
        return RepositoryResult(success: null, error: 'Arsen: ${e.toString()}');
      }

      return RepositoryResult(success: true, error: null);
    } else {
      return RepositoryResult(success: null, error: 'password don`t match');
    }
  }
}
