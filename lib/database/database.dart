import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/person_dao.dart';
import 'entity/person.dart';

part 'database.g.dart';
//flutter packages pub run build_runner build

@Database(version: 1, entities: [Person])
abstract class AppDatabase extends FloorDatabase{
  PersonDao get personDao;
}