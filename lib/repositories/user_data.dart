// user_data.dart
import '../models/user_model.dart';

class UserData {
  UserModel? _user;

  void setUser(UserModel user) {
    _user = user;
  }

  UserModel? getUser() {
    return _user;
  }

  bool hasUser() {
    return _user != null;
  }
}
