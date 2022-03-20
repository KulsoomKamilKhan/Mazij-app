import 'dart:convert';
import 'package:Mazaj/data/models/follow_model.dart';
import 'package:http/http.dart' as http;

class FollowRepository {
  static const base = "https://mazij-backend.herokuapp.com/followers/";

  Future<List<dynamic>> getAllInstances() async {
    Uri local = Uri.parse(base);
    var response = await http.get(local);

    var jsonObjs = jsonDecode(response.body);

    List<dynamic> profiles =
        jsonObjs.map((prof) => Follow.fromJson(prof)).toList();

    if (response.statusCode == 200) {
      return profiles;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<String>> getFollowsByUser(String? username) async {
    List<String> users = [];
    var response = await getAllInstances();
    int i = 0;
    while (i < response.length) {
      if ((response[i].followers).compareTo(username!) == 0) {
        users.add(response[i].follows);
      }
      i++;
    }
    return users;
  }

  Future<bool> Create(String fr, String fo) async {
    Uri local = Uri.parse(base + "user/${fr}");

    Map<String, dynamic> body = {"followers": fr, "follows": fo};
    var response = await http.post(
      local,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create profile');
    }
  }

  Future<bool> Delete(String fr, String fo) async {
    var response = await getAllInstances();
    int i = 0;
    int id = 0;
    while (i < response.length) {
      if ((response[i].followers.compareTo(fr) == 0) &&
          (response[i].follows.compareTo(fo) == 0)) {
        id = response[i].id;
      }
      i++;
    }
    Uri local = Uri.parse(base + "delete/${id}");
    var response1 =
        await http.delete(local, headers: {"Content-Type": "application/json"});
    if (response1.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete profile');
    }
  }
}
