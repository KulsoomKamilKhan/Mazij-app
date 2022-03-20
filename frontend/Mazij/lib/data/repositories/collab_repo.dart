import 'dart:convert';
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/collab_model.dart';
import 'package:Mazaj/data/models/library_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:http/http.dart' as http;

class CollabRepository {
  static const base = "http://bhavikakaliya.pythonanywhere.com/posts/";

  Future<List<Collab>> getDraftsByUsername(String? user) async {
    Uri local = Uri.parse(base + "draft-mashup/${user}/");
    var response = await http.get(local);
    Iterable postList = jsonDecode(response.body);
    List<Collab> posts = postList.map((post) => Collab.fromJson(post)).toList();
    if (response.statusCode == 200) {
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<bool> createPost(String user, String draft) async {
    Uri local = Uri.parse(base + "draft-mashup/${user}/");
    Map<String, dynamic> postBody = {
      "user": user,
      "draft": draft,
    };
    var response = await http.post(local,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(postBody));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<bool> deletePost(int id) async {
    Uri local = Uri.parse(base + "draft-delete/${id}/");
    var response =
        await http.delete(local, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete post');
    }
  }
}
