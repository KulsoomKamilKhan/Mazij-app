import 'dart:convert';
import 'package:Mazaj/bloc/post_bloc/post_bloc.dart';
import 'package:Mazaj/data/models/library_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  static const base = "https://mazij-backend.herokuapp.com/posts/";

  Future<List<Post>> getPostsByUsername(String? user) async {
    Uri local = Uri.parse(base + "${user}/");
    var response = await http.get(local);
    Iterable postList = jsonDecode(response.body);
    List<Post> posts = postList.map((post) => Post.fromJson(post)).toList();
    if (response.statusCode == 200) {
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Library>> GetPosts() async {
    Uri local = Uri.parse(base);
    var response = await http.get(local);
    Iterable postList = jsonDecode(response.body);
    List<Library> posts =
        postList.map((post) => Library.fromJson(post)).toList();
    if (response.statusCode == 200) {
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<bool> createPost(String post, String user, String caption, int upvotes,
      String collaborators) async {
    //String collaborators
    Uri local = Uri.parse(base + "${user}/create/");
    print(local);
    Map<String, dynamic> postBody = {
      "post": post,
      "user": user,
      "caption": caption,
      "upvotes": upvotes,
      "collaborators": collaborators
      //"collaborators": collaborators
    };
    print(postBody.toString());

    var response = await http.post(local,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(postBody));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<bool> deletePost(int id) async {
    Uri local = Uri.parse(base + "delete-post/${id}/");
    var response =
        await http.delete(local, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete post');
    }
  }

  Future<bool> upvotePost(Post post) async {
    Uri local = Uri.parse(base + "delete-post/${post.id}/");
    print("in upv po repo");
    print(local);
    print(post.upvotes);
    var response = await http.put(
      local,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(post),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update profile');
    }
  }

  Future<bool> sendEmail(String _loggeduser, String user, int id) async {
    Uri local = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    Map<String, dynamic> postBody = {
      "service_id": "service_33uypns",
      "template_id": "template_rih2a5f",
      "user_id": "user_5eUULKImN9Mn9uQIHBj5U",
      "template_params": {
        "message":
            "post by ${user} with the post id- ${id} has been reported by ${_loggeduser}"
      }
    };
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
