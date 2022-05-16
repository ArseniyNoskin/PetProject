import 'package:floor/floor.dart';

@Entity(indices: [Index(value: ['email'], unique: true)])
class Person {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String username;
  final String email;
  final String password;
  final int age;

  Person(this.id, this.username, this.email, this.password, this.age);
}
