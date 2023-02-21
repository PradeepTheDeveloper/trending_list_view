import 'package:dio/dio.dart';

import '../modal/user.dart';

class UserService {
  final Dio _dio = Dio();

  Future<List<User>> getUsers() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/users');
      final List<dynamic> data = response.data;
      final List<User> users = data.map((json) => User.fromJson(json)).toList();
      return users;
    } catch (error) {
      throw error;
    }
  }
}
