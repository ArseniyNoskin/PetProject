import 'package:floor/floor.dart';
import 'package:new_project/database/entity/person.dart';

@dao
abstract class PersonDao{
  @Query('SELECT * FROM Person')
  Future<List<Person>> findAllPerson();

  @Query('SELECT * FROM Person WHERE id = :id')
  Stream<Person?> findPersonById(int id);

  @Query('SELECT * FROM Person WHERE username = :username')
  Future<Person?> findPersonByUsername(String username);

  @Query('SELECT * FROM Person WHERE email = :email')
  Future<Person?> findPersonByEmail(String email);

  @Query('DELETE FROM Person')
  Future<void> deleteAllPersons();

  @Query('UPDATE Person SET password =:newPassword WHERE email =:userEmail')
  Future<void> updatePassword(String userEmail, String newPassword);

  @delete
  Future<void> deletePerson(Person person);

  @insert
  Future<void> insertPerson(Person person);
}