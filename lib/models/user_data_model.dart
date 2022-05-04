class UserDataModel {
  String? errorMessage;
  String? email;
  String? name;
  int? age;

  UserDataModel(this.errorMessage, this.email, this.name, this.age);

  UserDataModel.error(this.errorMessage) {
    email = null;
    name = null;
    age = null;
  }

  UserDataModel.success(this.email, this.name, this.age) {
    errorMessage = null;
  }
}
