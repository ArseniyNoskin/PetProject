import 'package:new_project/models/user_data_model.dart';

class RepositoryResult{
  String? error;
  UserDataModel? success;

  RepositoryResult({this.success, this.error});
}