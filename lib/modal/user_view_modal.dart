import 'package:flutter/cupertino.dart';

import '../controller/user_service.dart';
import 'user.dart';

class UserViewModel with ChangeNotifier {
  final UserService _userService = UserService();
  List<User> _users = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;

    try {
      _users = await _userService.getUsers();
    } catch (error) {
      _errorMessage = 'An error occurred while fetching users: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
