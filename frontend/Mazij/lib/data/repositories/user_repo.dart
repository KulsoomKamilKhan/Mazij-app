import 'dart:convert';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  static const base = "http://127.0.0.1:8000/users";

  Future<List<User>> GetUsers() async {
    Uri local = Uri.parse(base);
    var response = await http.get(local);
    Iterable userList = jsonDecode(response.body);
    List<User> users = userList.map((user) => User.fromJson(user)).toList();
    if (response.statusCode == 200) {
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUserByusername(String? username) async {
    Uri local = Uri.parse(base + "/${username}");
    var response = await http.get(local);
    var jsonUser = jsonDecode(response.body);
    User user = User.fromJson(jsonUser);

    if (response.statusCode == 200) {
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<bool> createUser(User user) async {
    Uri local = Uri.parse(base + "/user/create/");
    var response = await http.post(
      local,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        user.toJson(),
      ),
    );

    if (response.statusCode == 201) {
      // 201 if resource is created
      return true;
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<bool> updateUser(User user) async {
    Uri local = Uri.parse(base + "/${user.username}/update/");
    var response = await http.put(
      local,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update user details');
    }
  }

  Future<bool> deleteUser(String username) async {
    Uri local = Uri.parse(base + "/${username}/delete");
    var response =
        await http.delete(local, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete post');
    }
  }

  Future<bool> sendEmail(User user, String code) async {
    Uri local = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    Map<String, dynamic> postBody = {
      "service_id": "service_33uypns",
      "template_id": "template_rcf4mht",
      "user_id": "user_5eUULKImN9Mn9uQIHBj5U",
      "template_params": {
        "code": code,
        "username": user.username,
        "email": user.email
      }
    };
    print(user.username);
    print(user.email);
    print(code);
    var response = await http.post(local,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(postBody));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to send email');
    }
  }
}
