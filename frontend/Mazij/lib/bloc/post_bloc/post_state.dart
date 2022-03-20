part of 'post_bloc.dart';

@immutable
abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostCreated extends PostState {}

class PostLoaded extends PostState {
  List<Post> posts;
  PostLoaded({required this.posts});
}

class PostError extends PostState {
  final error;
  const PostError({this.error});
}

class PostDeleted extends PostState {}

class PostUpvoted extends PostState {}

class LibrariesLoaded extends PostState {
  List<Library> posts;
  LibrariesLoaded({required this.posts});
}

