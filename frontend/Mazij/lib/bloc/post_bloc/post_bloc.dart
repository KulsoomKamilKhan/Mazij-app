import 'dart:io';
import 'package:Mazaj/data/models/library_model.dart';
import 'package:Mazaj/data/models/post_model.dart';
import 'package:Mazaj/data/repositories/post_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepo = PostRepository();
  PostBloc() : super(PostInitial());

  var storage = const FlutterSecureStorage();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is GetPostsByUsername) {
      yield* mapGetPostsByUsername();
    } else if (event is GetPosts) {
      yield* mapGetAllPosts();
    } else if (event is GetProfilePosts) {
      yield* mapGetProfilePosts(event.user);
    } else if (event is CreatePost) {
      yield* mapCreatePost(
          event.post, event.user, event.caption, event.upvotes, event.collaborators);
    } else if (event is DeletePost) {
      yield* mapDeletePost(event.id);
    } else if (event is UpvotePost) {
      yield* mapUpvotePost(event.post);
    }
  }

  Stream<PostState> mapGetPostsByUsername() async* {
    yield PostLoading();
    try {
      var username = (await storage.read(key: 'username')).toString();

      List<Post> response = await _postRepo.getPostsByUsername(username);

      yield PostLoaded(posts: response);
    } on SocketException {
      yield const PostError(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const PostError(
        error: ('No Service'),
      );
    } on FormatException {
      yield const PostError(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield PostError();
    }
  }

  Stream<PostState> mapGetProfilePosts(String username) async* {
    yield PostLoading();
    try {
      print("in post bloc posts");
      List<Post> response = await _postRepo.getPostsByUsername(username);
      print(response.length);
      yield PostLoaded(posts: response);
    } on SocketException {
      yield const PostError(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const PostError(
        error: ('No Service'),
      );
    } on FormatException {
      yield const PostError(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield PostError();
    }
  }

  Stream<PostState> mapGetAllPosts() async* {
    yield PostLoading();
    try {
      var response = await _postRepo.GetPosts();
      yield LibrariesLoaded(posts: response);
    } on SocketException {
      yield const PostError(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const PostError(
        error: ('No Service'),
      );
    } on FormatException {
      yield const PostError(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield PostError();
    }
  }

  Stream<PostState> mapCreatePost(
      String post, String user, String caption, int upvotes, String collaborators) async* {
    yield PostLoading();
    try {
      var response = await _postRepo.createPost(post, user, caption, upvotes, collaborators);
      if (response) {
        yield PostCreated();
      } else {
        yield PostError();
      }
    } on SocketException {
      yield const PostError(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const PostError(
        error: ('No Service'),
      );
    } on FormatException {
      yield const PostError(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield PostError();
    }
  }

  Stream<PostState> mapDeletePost(int id) async* {
    try {
      var response = await _postRepo.deletePost(id);
      if (response) {
        yield PostDeleted();
      } else {
        yield PostError();
      }
    } on SocketException {
      yield const PostError(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const PostError(
        error: ('No Service'),
      );
    } on FormatException {
      yield const PostError(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield PostError();
    }
  }

  Stream<PostState> mapUpvotePost(Post post) async* {
    try {
      print("po upv bloc");
      print(post.upvotes);
      var response = await _postRepo.upvotePost(post);
      if (response) {
        print(" po bloc ");
        print(response);
        yield PostUpvoted();
      } else {
        yield PostError();
      }
    } on SocketException {
      yield const PostError(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const PostError(
        error: ('No Service'),
      );
    } on FormatException {
      yield const PostError(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield PostError();
    }
  }
}
