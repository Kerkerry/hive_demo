part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

class LoadingPostsState extends PostState {
  const LoadingPostsState();
}

class PostsLoadedState extends PostState {
  final List posts;

  const PostsLoadedState({required this.posts});

  @override
  List<Object> get props => [];
}

class LoadingPostState extends PostState {
  const LoadingPostState();
}

class PostLoadedState extends PostState {
  final Post post;

  const PostLoadedState({required this.post});
  @override
  List<Object> get props => [post.id];
}

class PostErrorState extends PostState {
  final String? message;

  const PostErrorState({required this.message});
  @override
  List<Object> get props => [message!];
}
