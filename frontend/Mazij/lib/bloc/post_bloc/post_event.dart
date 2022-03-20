part of 'post_bloc.dart';

@immutable
abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPostsByUsername extends PostEvent {
  const GetPostsByUsername();
}

class GetProfilePosts extends PostEvent {
  final String user;
  const GetProfilePosts({required this.user});
}

class GetPosts extends PostEvent {
  const GetPosts();
}

class CreatePost extends PostEvent {
  final String post;
  final String user;
  final String caption;
  final int upvotes;
  final String collaborators;

  const CreatePost({
    required this.post,
    required this.user,
    required this.caption,
    required this.upvotes,
    required this.collaborators
  });
}

class DeletePost extends PostEvent {
  final int id;
  const DeletePost({required this.id});
}

class UpvotePost extends PostEvent {
  final Post post;
  const UpvotePost({required this.post});
}
