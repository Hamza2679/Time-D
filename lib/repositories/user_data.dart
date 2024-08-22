// user_data.dart
import '../models/user_model.dart';

class UserData {
  UserModel? _user; // Storing a single user

  // Method to add or update user
  void setUser(UserModel user) {
    _user = user;
  }

  // Method to get the user
  UserModel? getUser() {
    return _user;
  }

  // Method to check if a user is available
  bool hasUser() {
    return _user != null;
  }
}
