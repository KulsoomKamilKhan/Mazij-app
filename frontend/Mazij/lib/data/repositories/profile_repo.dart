import 'dart:convert';
import 'package:Mazaj/data/models/profile_model.dart';
import 'package:Mazaj/screens/profiles/create_profile.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  static const base = "http://bhavikakaliya.pythonanywhere.com/profiles/";

  Future<Profile> getProfileByUsername(String? username) async {
    Uri local = Uri.parse(base + "${username}/");
    var response = await http.get(local);
    var jsonObj = jsonDecode(response.body);
    Profile profile = Profile.fromJson(jsonObj);
    if (response.statusCode == 200) {
      return profile;
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<List<dynamic>> getProfiles() async {
    Uri local = Uri.parse(base);
    var response = await http.get(local);
    var jsonObjs = jsonDecode(response.body);
    List<dynamic> profiles =
        jsonObjs.map((prof) => Profile.fromJson(prof)).toList();
    if (response.statusCode == 200) {
      return profiles;
    } else {
      throw Exception('Failed to load profiles');
    }
  }

  Future<bool> UpdateProfile(Profile profile) async {
    Uri local = Uri.parse(base + "${profile.username}/");

    var response = await http.put(
      local,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(profile.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update profile');
    }
  }
}
